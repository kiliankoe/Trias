import XCTest
@testable import Trias
import XMLCoder

final class TriasTests: XCTestCase {
    func testEncode() {
        let msg = TriasOutgoing(request: ServiceRequest(timestamp: Date(),
                                                        requestorRef: "DemoRequestorRef",
                                                        payload: LocationInformationRequest(name: "Albertplatz")))
        let encoder = XMLEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted

        let xmlData = try! encoder.encode(msg, withRootKey: "Trias")
        let xmlString = String(data: xmlData, encoding: .utf8)!

        XCTAssert(xmlString.contains("<siri:RequestorRef>DemoRequestorRef</siri:RequestorRef>"))
        XCTAssert(xmlString.contains("<Text>Albertplatz</Text>"))
        print(xmlString)
    }
}
