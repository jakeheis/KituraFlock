import XCTest
@testable import KituraFlock

class KituraFlockTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(KituraFlock().text, "Hello, World!")
    }


    static var allTests : [(String, (KituraFlockTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
