//
//  Networking.swift
//  Qudra
//
//  Created by Mobin Jahantark on 2/22/23.
//

import Foundation

class Networking: NetworkingInterface {
    
    private var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request(_ request: URLRequest, responseHandler handler: @escaping (Result<Data, NetworkingError>) -> Void) {
        let dataTask = session.dataTask(with: request) { [weak self] data, response, error in
            debugPrint("Response for \(String(describing: request.url)) --> ", data?.prettyPrintedJSONString ?? "")
            DispatchQueue.main.async {
                if let error {
                    handler(.failure(.customError(error: error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, let _ = response else {
                    return handler(.failure(.responseIsNotValid))
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    return handler(.failure(.invalidStatusCode))
                }
                
                guard let data = data else {
                    return handler(.failure(.emptyResponse))
                }
                
                handler(.success(data))
            }
        }
        dataTask.resume()
    }
    
}


extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
