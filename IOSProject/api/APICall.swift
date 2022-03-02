//
//  APICall.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

import Foundation

class APICall : ObservableObject {
    
    func getCountries(completionHandler: @escaping (Result<[Country], Error>) -> Void) {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url,  completionHandler: {(data, response, error) in
            if let error = error {
                 print("Error with fetching countries: \(error)")
                 return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                     (200...299).contains(httpResponse.statusCode) else {
                 print("Error with the response, unexpected status code: \(response)")
                 return
            }
            
            do {
                let countriesSummary = try! JSONDecoder().decode([Country].self, from: data!)
                completionHandler(.success(countriesSummary))
            }
            catch let jsonError {
                completionHandler(.failure(jsonError.localizedDescription as! Error))
            }
            
        })
        task.resume()
    }
    
    func getCountriesByCode(completionHandler: @escaping (Result<[Country], Error>) -> Void, code: String) {
        guard let url = URL(string: "https://restcountries.com/v3.1/alpha/https://restcountries.com/v3.1/alpha/\(code)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url,  completionHandler: {(data, response, error) in
            if let error = error {
                 print("Error with fetching countries: \(error)")
                 return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                     (200...299).contains(httpResponse.statusCode) else {
                 print("Error with the response, unexpected status code: \(response)")
                 return
            }
            
            do {
                let countriesSummary = try! JSONDecoder().decode([Country].self, from: data!)
                completionHandler(.success(countriesSummary))
            }
            catch let jsonError {
                completionHandler(.failure(jsonError.localizedDescription as! Error))
            }
            
        })
        task.resume()
    }
}
