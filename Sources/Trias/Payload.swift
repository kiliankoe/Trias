public protocol Payload {
    var codingKey: AnyCodingKey { get }
}

extension Payload {
    public var codingKey: AnyCodingKey {
        AnyCodingKey(rawValue: String(describing: Self.self))
    }
}
