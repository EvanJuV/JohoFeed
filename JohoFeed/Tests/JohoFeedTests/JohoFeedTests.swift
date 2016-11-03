import XCTest
@testable import JohoFeed

class JohoFeedTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(JohoFeed().text, "Hello, World!")
    }


    static var allTests : [(String, (JohoFeedTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
