//
//  CakeService.swift
//  cakefactory
//
//  Created by Jose Maria Marquez on 22/11/21.
//

import Foundation

protocol CakeServiceProtocol {
    func getCakes(completionHandler: @escaping (Result<[Cake], Error>) -> Void)
}

class CakeService: CakeServiceProtocol {
    
    let session = URLSession.shared


    func getCakes(completionHandler: @escaping (Result<[Cake], Error>) -> Void) {
        let url = URL(string: EndpointsCakes.listCakes.rawValue)!
        let request = URLRequest(url: url)

        let task = session.dataTask(with: request,
                                    completionHandler: { (data, response, error) in
            if error != nil {
                completionHandler(.failure(ResponseError.other))
            } else if let data = data {
                do {
                    if let responseCake = try? JSONDecoder().decode([Cake].self, from: data) {
                        completionHandler(.success(responseCake))
                    } else {
                        completionHandler(.failure(ResponseError.wrongJsonError))
                    }
                }
            } else {
                completionHandler(.failure(ResponseError.other))
            }
        })
        task.resume()
    }

}

enum EndpointsCakes: String {
    case listCakes = "https://gist.githubusercontent.com/juananthony/c51c635c877d53d0fbc7d803f23af7ea/raw/0d4454a75859e8f94834a3de257b0b69a77e0b10/cakes"
}

enum ResponseError: Error {
    case wrongJsonError
    case other
}
