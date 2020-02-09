public struct LocationParameter: Codable {
    /// Allowed location object types.
    public let type: String?
    /// Include modes of transport for results in the response.
    public let includePtModes: Bool?

    public init(type: String?, includePtModes: Bool?) {
        self.type = type
        self.includePtModes = includePtModes
    }

    private enum CodingKeys: String, CodingKey {
        case type = "Type"
        case includePtModes = "IncludePtModes"
    }
}
