public struct LocationReference: Encodable {
    public let stopPointReference: String?
    public let geoPosition: GeoPosition?
    public let locationName: LocationName?

    internal init(stopPointReference: String? = nil,
                  geoPosition: GeoPosition? = nil,
                  locationName: LocationName? = nil) {
        self.stopPointReference = stopPointReference
        self.geoPosition = geoPosition
        self.locationName = locationName
    }

    private enum CodingKeys: String, CodingKey {
        case stopPointReference = "StopPointRef"
        case geoPosition = "GeoPosition"
        case locationName = "LocationName"
    }
}

public struct LocationName: Codable, ExpressibleByStringLiteral {
    public let text: String

    public init(stringLiteral value: String) {
        self.text = value
    }

    public init(_ string: String) {
        self.init(stringLiteral: string)
    }

    private enum CodingKeys: String, CodingKey {
        case text = "Text"
    }
}
