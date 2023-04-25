//
//  NetworkingInterface.swift
//  Qudra
//
//  Created by Mobin Jahantark on 2/22/23.
//

import Foundation

protocol NetworkingInterface {
    func request(_ request: URLRequest, responseHandler handler: @escaping (Result<Data, NetworkingError>) -> Void)
}
