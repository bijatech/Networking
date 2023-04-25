//
//  NetworkingError.swift
//  Qudra
//
//  Created by Mobin Jahantark on 2/22/23.
//

import Foundation

enum NetworkingError: Error {
    case responseIsNotValid
    case unknownErrorOccurred
    case emptyResponse
    case invalidStatusCode
    case couldNotDecodeErrorModel
    case tempURLIsNotValid
    case customError(error: Error)
    
    
    var localizedDescription: String {
        switch self {
        case .responseIsNotValid:
            return "Response is not valid."
        case .unknownErrorOccurred:
            return "unknown Error occurred in network."
        case .emptyResponse:
            return "Response is empty."
        case .invalidStatusCode:
            return "Status code is not in 200..299 range."
        case .couldNotDecodeErrorModel:
            return "Could not decode your error model."
        case .tempURLIsNotValid:
            return "Your temp URL is not valid."
        case .customError(error: let customError):
            return customError.localizedDescription
        }
    }
}
