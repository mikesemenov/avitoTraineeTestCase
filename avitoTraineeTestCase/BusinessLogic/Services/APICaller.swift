//
//  APICaller.swift
//  avitoTraineeTestCase
//
//  Created by Mikhail Semenov on 09.09.2021.
//

import Foundation

public enum HTTPError: Error {
    case unknown
    case unexpectedStatus(HTTPURLResponse)
    case decodeError
}

final class APICaller {
    
    let persistencyService = DefaultPersistencyService()
    
    static let shared = APICaller()
    
    struct Constants {
        static let baseURL = URL(staticString: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c")
    }
    
    func requestJSON (completion: @escaping (Result<MainResponse, Error>) -> Void) {
        if persistencyService.compareDateFromStore(key: "Date") {
            URLSession.shared.dataTask(with: Constants.baseURL) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      let data = data else {
                    completion(.failure(HTTPError.unknown))
                    return
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(HTTPError.unexpectedStatus(httpResponse)))
                    return
                }
                do {
                    let decoder = AppJSONDecoder()
                    let result = try decoder.decode(MainResponse.self, from: data)
                    self.persistencyService.save(data, key: "ResponseData")
                    self.persistencyService.saveDate(Date(), key: "Date")
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }.resume()
            
        } else {
            do {
                guard let data = self.persistencyService.get(key: "ResponseData") else { return }
                let decoder = AppJSONDecoder()
                let result = try decoder.decode(MainResponse.self, from: data)
                self.persistencyService.save(data, key: "ResponseData")
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
    }
}
