import XCTest
@testable import Network

final class NetworkTests: XCTestCase {
    func testLoadRequest()  {
       
        let network = Network()
        
        network.loadRequest { result in
            XCTAssertNoThrow(try? result.get(), "Data should not be nill")
        }
    }
}
