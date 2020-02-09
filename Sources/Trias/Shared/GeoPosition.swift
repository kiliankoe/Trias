public struct GeoPosition: Codable {
    public let longitude: Double
    public let latitude: Double
    public let altitude: Double?

    public init(longitude: Double, latitude: Double, altitude: Double? = nil) {
        self.longitude = longitude
        self.latitude = latitude
        self.altitude = altitude
    }

    private enum CodingKeys: String, CodingKey {
        case longitude = "Longitude"
        case latitude = "Latitude"
        case altitude = "Altitude"
    }
}
