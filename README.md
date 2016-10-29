# KituraFlock

Automated deployment of your [Kitura](https://github.com/IBM-Swift/Kitura) server using [Flock](https://github.com/jakeheis/Flock).

# Installation
Add these lines to `deploy/FlockDependencies.json`:
```
"dependencies" : [
       ...
       {
           "url" : "https://github.com/jakeheis/KituraFlock",
           "version": "0.0.1"
       }
]
```
In your `Flockfile` add:
```swift
import Flock
import KituraFlock

...

Flock.use(Flock.Kitura)
```
# Config
These fields are open for customization in your `config/deploy/Always.swift` and related configuration files:
```swift
public extension Config {
    static var outputLog = "/dev/null"
    static var errorLog = "/dev/null"
}
```
If you set these variable to anything other than `/dev/null`, you'll likely want to turn off stdout bufferring to ensure log files are properly written to:
```swift
// Sources/main.swift

#if os(Linux)
import Glibc
#else
import Darwin
#endif
import Kitura

setbuf(stdout, nil)

let router = Router()
...
```
Run `flock tools` again before deploying to install Kitura's tools on your server.
# Tasks
```
kitura:tools    # Hooks .after("tools:dependencies")
kitura:stop     # Hooks .before("deploy:link")
kitura:start    # Hooks .after("deploy:link")
kitura:ps
```
`KituraFlock` hooks into the deploy process to automatically restart the server after the new release is built, and into the tools process to install `Kitura` tools, so you should never have to call these tasks directly.
