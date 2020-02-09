import Foundation
import XMLCoder

public class Client {
    let url: URL
    let requestorRef: String

    public init(url: URL, requestorRef: String) {
        self.url = url
        self.requestorRef = requestorRef
    }

    public func send<R: Request & Payload>(request: R,
                                           session: URLSession,
                                           completion: @escaping (Result<R.Response, TriasError>) -> Void) {
        let message = TriasOutgoing(request: ServiceRequest(timestamp: Date(),
                                                            requestorRef: self.requestorRef,
                                                            payload: request))
        let encoder = XMLEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted

        var requestData: Data
        do {
            requestData = try encoder.encode(message, withRootKey: "Trias", header: XMLHeader(version: 1.0, encoding: "UTF-8"))
        } catch {
            completion(.failure(.other(error)))
            return
        }

        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = requestData
        urlRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")

        let task = session.dataTask(with: urlRequest) { data, response, error in
            print(data, response, error)
            completion(.failure(.placeholder))
        }

        task.resume()
    }
}

extension Client {
    public func requestLocationInformation(name: String,
                                           restrictions: Restrictions = .default,
                                           date: Date = Date(),
                                           session: URLSession = .shared,
                                           completion: @escaping (Result<LocationInformationRequest.Response, TriasError>) -> Void) {
        let request = LocationInformationRequest(name: name, restrictions: restrictions)
        #if DEBUG
        print("Sending request: \(request)")
        #endif
        send(request: request, session: session, completion: completion)
    }
}

public protocol Request: Encodable {
    associatedtype Response
}

public protocol Response {}
public enum TriasError: Error {
    case other(Error)
    case placeholder
}

public struct LocationInformationResponse: Response {}
