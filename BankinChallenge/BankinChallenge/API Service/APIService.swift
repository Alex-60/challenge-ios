//
//  APIService.swift
//  BankinChallenge
//
//  Created by Alexandre Legros on 22/12/2021.
//

import Foundation

struct APIService {
    
    func getListBank(completion: @escaping(Result<DatasListBanks,Error>) ->()) {
        let listBankURL = URL(string: Host.production.rawValue + Endpoints.listOfBanks.rawValue)!
        var request = URLRequest(url: listBankURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Header().headers
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(ErrorAPI.errorCallAPI))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(ErrorAPI.errorHTTP))
                return
            }
            if let data = data {
                do {
                    let jsonListOfBank = try JSONDecoder().decode(DatasListBanks.self, from: data)
                    completion(.success(jsonListOfBank))
                } catch {
                    completion(.failure(ErrorAPI.jsonDecodeErrorListOfBank))
                }
            } else {
                completion(.failure(ErrorAPI.noneData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping ((Data?) -> Void)) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let _ = error {
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else {
                completion(nil)
                return
            }
            
            if let data = data {
                DispatchQueue.main.async() {
                    completion(data)
                }
            }
        })
        task.resume()
    }
}
