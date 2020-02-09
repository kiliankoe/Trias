import XMLCoder

struct TriasOutgoing<P: Encodable & Request & Payload>: Encodable, DynamicNodeEncoding {
    let namespace = "http://www.vdv.de/trias"
    let version = "1.2"

    let request: ServiceRequest<P>

    private enum CodingKeys: String, CodingKey {
        case namespace = "xmlns"
        case version
        case request = "ServiceRequest"
    }

    static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        switch key {
        case CodingKeys.namespace: return .attribute
        case CodingKeys.version: return .attribute
        default: return .element
        }
    }
}
