import XCTest
@testable import Trias
import XMLCoder

final class TriasTests: XCTestCase {
    var encoder: XMLEncoder!

    override func setUp() {
        self.encoder = XMLEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
    }

    func testEncode() {
        let msg = TriasOutgoing(request: ServiceRequest(timestamp: Date(),
                                                        requestorRef: "DemoRequestorRef",
                                                        payload: LocationInformationRequest(initialInput: InitialLocationInput(locationName: "Albertplatz"))))
        let xmlData = try! encoder.encode(msg, withRootKey: "Trias")
        let xmlString = String(data: xmlData, encoding: .utf8)!

        XCTAssert(xmlString.contains("<siri:RequestorRef>DemoRequestorRef</siri:RequestorRef>"))
        XCTAssert(xmlString.contains("<LocationName>Albertplatz</LocationName>"))
        print(xmlString)
    }
}
