import Foundation
import XMLCoder

public struct ServiceRequest<P: Encodable & Request & Payload>: Encodable {
    public let timestamp: Date
    public let requestorRef: String
    let payload: RequestPayload<P>

    private enum CodingKeys: String, CodingKey {
        case timestamp = "siri:RequestTimestamp"
        case requestorRef = "siri:RequestorRef"
        case payload = "RequestPayload"
    }

    public init(timestamp: Date = Date(),
                requestorRef: String,
                payload: P) {
        self.timestamp = timestamp
        self.requestorRef = requestorRef
        self.payload = RequestPayload(payload: payload)
    }
}

struct RequestPayload<P: Encodable & Request & Payload>: Encodable {
    let payload: P

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AnyCodingKey.self)
        try container.encode(payload, forKey: payload.codingKey)
    }
}
