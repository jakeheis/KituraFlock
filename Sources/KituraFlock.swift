import Flock
import Foundation

public extension Flock {
    static let Kitura: [Task] = [
        ToolsTask(),
        StopTask(),
        StartTask(),
        PsTask()
    ]
}

public extension Config {
    static var outputLog = "/dev/null"
    static var errorLog = "/dev/null"
}

let kitura = "kitura"

public class ToolsTask: Task {
    public let name = "tools"
    public let namespace = kitura
    public let hookTimes: [HookTime] = [.after("tools:dependencies")]
    
    public func run(on server: Server) throws {
        print("Installing Kitura dependencies")
        try server.execute("sudo apt-get -qq install libssl-dev")
    }
}

public class StopTask: Task {
    public let name = "stop"
    public let namespace = kitura
    public let hookTimes: [HookTime] = [.before("deploy:link")]
    
    public func run(on server: Server) throws {
        if let pid = try findServerPid(on: server) {
            try server.execute("kill -9 \(pid)")
        } else {
            print("Kitura not running")
        }
    }
}

public class StartTask: Task {
    public let name = "start"
    public let namespace = kitura
    public let hookTimes: [HookTime] = [.after("deploy:link")]
    
    public func run(on server: Server) throws {
        print("Starting Kitura")
        try server.execute("nohup \(Paths.executable) >> \(Config.outputLog) 2>> \(Config.errorLog) &")
        try invoke("kitura:ps")
    }
}

public class PsTask: Task {
    public let name = "ps"
    public let namespace = kitura
    
    public func run(on server: Server) throws {
        if let pid = try findServerPid(on: server) {
            print("Kitura running as process \(pid)")
        } else {
            print("Kitura not running")
        }
    }
}

private func findServerPid(on server: Server) throws -> String? {
    guard let processes = try server.capture("ps aux | grep \".build\"") else {
        return nil
    }
    
    let lines = processes.components(separatedBy: "\n")
    for line in lines where !line.contains("grep") {
        let segments = line.components(separatedBy: " ").filter { !$0.isEmpty }
        if segments.count > 1 {
            return segments[1]
        }
        return segments.count > 1 ? segments[1] : nil
    }
    return nil
}
