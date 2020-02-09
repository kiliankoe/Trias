public struct InitialLocationInput: Encodable {
    public let locationName: String?
    public let geoPosition: GeoPosition?
    public let geoRestriction: GeoRestrictions?

    public init(locationName: String? = nil, geoPosition: GeoPosition? = nil, geoRestriction: GeoRestrictions? = nil) {
        self.locationName = locationName
        self.geoPosition = geoPosition
        self.geoRestriction = geoRestriction
    }

    private enum CodingKeys: String, CodingKey {
        case locationName = "LocationName"
        case geoPosition = "GeoPosition"
        case geoRestriction = "GeoRestriction"
    }
}
