import XMLCoder

public struct LocationInformationRequest: Encodable {
    public let initialInput: InitialLocationInput?
    public let locationReference: LocationReference?
    public let restrictions: LocationParameter?

    public init(initialInput: InitialLocationInput? = nil,
                locationReference: LocationReference? = nil,
                restrictions: LocationParameter? = nil) {
        assert(initialInput != nil || locationReference != nil)
        self.initialInput = initialInput
        self.locationReference = locationReference
        self.restrictions = restrictions
    }

    private enum CodingKeys: String, CodingKey {
        case initialInput = "InitialInput"
        case locationReference = "LocationRef"
        case restrictions = "Restrictions"
    }
}

extension LocationInformationRequest: Request {
    public typealias Response = LocationInformationResponse
}

extension LocationInformationRequest: Payload {}
