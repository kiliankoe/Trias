import Foundation
import XMLCoder

public class Client {
    public var url: URL
    public var requestorRef: String

    public var xmlHeader = XMLHeader(version: 1.0, encoding: "UTF-8", standalone: nil)

    public init(url: URL, requestorRef: String) {
        self.url = url
        self.requestorRef = requestorRef
    }

    public func send<R: Request & Payload>(request: R,
                                           session: URLSession = .shared,
                                           completion: @escaping (Result<R.Response, TriasError>) -> Void) {
        let message = TriasOutgoing(request: ServiceRequest(timestamp: Date(),
                                                            requestorRef: self.requestorRef,
                                                            payload: request))
        let encoder = XMLEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted

        var requestData: Data
        do {
            requestData = try encoder.encode(message, withRootKey: "Trias", header: self.xmlHeader)
        } catch {
            completion(.failure(.other(error)))
            return
        }

        #if DEBUG
        print("↗️ Sending Trias request:\n\(String(data: requestData, encoding: .utf8)!)\n")
        #endif

        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = requestData
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")

        let task = session.dataTask(with: urlRequest) { data, response, error in
            print("↘️ Received response:\n\(String(data: data!, encoding: .utf8)!)\n")
            completion(.failure(.placeholder))
        }

        task.resume()
    }
}

extension Client {
    public func requestLocationInformation(for name: String,
                                           closeTo geoPosition: GeoPosition? = nil,
                                           restrictedTo geoRestriction: GeoRestrictions? = nil,
                                           date: Date = Date(),
                                           session: URLSession = .shared,
                                           completion: @escaping (Result<LocationInformationRequest.Response, TriasError>) -> Void) {
        let request = LocationInformationRequest(initialInput: InitialLocationInput(locationName: name,
                                                                                    geoPosition: geoPosition,
                                                                                    geoRestriction: geoRestriction),
                                                 locationReference: nil,
                                                 restrictions: nil)
        send(request: request, session: session, completion: completion)
    }
}
