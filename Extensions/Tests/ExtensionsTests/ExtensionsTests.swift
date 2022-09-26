import XCTest
@testable import Extensions

final class ExtensionsTests: XCTestCase {
    
    func testDate() {
        let date = Date()
        let formattedDate = date.string(with: "mm/dd/yyyy")
        XCTAssertEqual(formattedDate.count, 10)
    }
    
    func testDateString() {
        let date = Date()
        let formattedDate = date.string(with: "mm/dd/yyyy")
        let backDate = formattedDate.date(with: "mm/dd/yyyy")
        XCTAssertNotNil(backDate)
    }
    
    func testFormateChanger() {
        let date = Date()
        let formattedDate = date.string(with: "mm/dd/yyyy")
        let changedFormat = formattedDate.date(from: "mm/dd/yyyy", toFormat: "MMM, dd yyyy")
        XCTAssertTrue(changedFormat.contains(","))
    }
    
    func testUnique() {
        let array = [1, 2, 3, 4, 5, 1, 1, 1, 1]
        let unique = array.unique()
        XCTAssertEqual(unique, [1, 2, 3, 4, 5])
    }
    
}
