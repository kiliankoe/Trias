import XMLCoder

public struct LocationInformationRequest: Encodable {
    public let locationReference: LocationReference
    public let restrictions: Restrictions

    private enum CodingKeys: String, CodingKey {
        case locationReference = "LocationRef"
        case restrictions = "Restrictions"
    }

    public init(name: String, restrictions: Restrictions = .default) {
        self.locationReference = LocationReference(locationName: LocationName(text: name))
        self.restrictions = restrictions
    }

    public init(locationReference: LocationReference, restrictions: Restrictions) {
        self.locationReference = locationReference
        self.restrictions = restrictions
    }
}

extension LocationInformationRequest: Request {
    public typealias Response = LocationInformationResponse
}

extension LocationInformationRequest: Payload {}

public struct LocationReference: Encodable {
    public let locationName: LocationName

    private enum CodingKeys: String, CodingKey {
        case locationName = "LocationName"
    }
}

public struct LocationName: Codable {
    public let text: String

    private enum CodingKeys: String, CodingKey {
        case text = "Text"
    }
}

public struct Restrictions: Codable {
    public let type: String
    public let includePtModes: Bool

    private enum CodingKeys: String, CodingKey {
        case type = "Type"
        case includePtModes = "IncludePtModes"
    }

    public static var `default`: Restrictions {
        Restrictions(type: "stop", includePtModes: true)
    }
}
