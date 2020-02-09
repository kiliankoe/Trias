public enum GeoRestrictions: Encodable {
    case circle(GeoCircle)
    case rectangle(GeoRectangle)
    case area(GeoArea)

    private enum CodingKeys: String, CodingKey {
        case circle = "Circle"
        case rectangle = "Rectangle"
        case area = "Area"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .circle(let circle):
            try container.encode(circle, forKey: .circle)
        case .rectangle(let rect):
            try container.encode(rect, forKey: .rectangle)
        case .area(let area):
            try container.encode(area, forKey: .area)
        }
    }
}

public struct GeoCircle: Codable {
    public let center: GeoPosition
    public let radius: UInt

    public init(center: GeoPosition, radius: UInt) {
        self.center = center
        self.radius = radius
    }

    private enum CodingKeys: String, CodingKey {
        case center = "Center"
        case radius = "Radius"
    }
}

public struct GeoRectangle: Codable {
    public let upperLeft: GeoPosition
    public let lowerRight: GeoPosition

    public init(upperLeft: GeoPosition, lowerRight: GeoPosition) {
        self.upperLeft = upperLeft
        self.lowerRight = lowerRight
    }

    private enum CodingKeys: String, CodingKey {
        case upperLeft = "UpperLeft"
        case lowerRight = "LowerRight"
    }
}

public struct GeoArea: Codable {
    public let polylinePoints: [GeoPosition]

    public init(polylinePoints: [GeoPosition]) {
        assert(polylinePoints.count >= 3)
        self.polylinePoints = polylinePoints
    }

    private enum CodingKeys: String, CodingKey {
        case polylinePoints = "PolylinePoint"
    }
}
