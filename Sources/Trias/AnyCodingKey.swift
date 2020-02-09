public struct AnyCodingKey: CodingKey, ExpressibleByStringLiteral {
    let rawValue: String

    public init?(stringValue: String) {
        self.rawValue = stringValue
    }

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }

    public init?(intValue: Int) {
        return nil
    }

    public var stringValue: String {
        rawValue
    }

    public var intValue: Int? = nil
}

