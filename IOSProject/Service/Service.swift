//
//  Service.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

import os.log
import Foundation

public class Service {
    
    public init() {}

    typealias countryCompletion = (_ response: [Country]?, _ error: Error?) -> Void
    typealias stringCompletion = (_ response: [String]?, _ error: Error?) -> Void
    
    func getCountries(completion: @escaping countryCompletion) {
        requestCountriesData(url: Path.all) { response, error in
            completion(response, error)
        }
    }
    
    func getCountriesRandomFlag(completion: @escaping stringCompletion) {
        guard let urlSafe = URL(string: "\(Path.all)") else {
            os_log("Error: invalid url: %@", log: OSLog.default, type: .error, "\(Path.all)")
            completion(nil, RequestError.badFormatURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlSafe) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, RequestError.noResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                if response.statusCode == 404 {
                    os_log("No country matching the request was found", log: OSLog.default, type: .error)
                    completion([], nil)
                } else {
                    os_log("Unexpected response from the API: %@", log: OSLog.default, type: .error, response.debugDescription)
                    completion(nil, RequestError.invalidResponse)
                }
                return
            }
            
            guard let dataSafe = data else {
                os_log("Unexpected data from the API: %@", log: OSLog.default, type: .error, data.debugDescription)
                completion(nil, RequestError.invalidData)
                return
            }
            
            do {
                guard let responseJSON = try JSONSerialization.jsonObject(with: dataSafe, options: []) as? [[String: Any]] else {
                    os_log("Unexpected data format from the API: %@", log: OSLog.default, type: .error, dataSafe.debugDescription)
                    completion(nil, RequestError.invalidData)
                    return
                }
                
                
                var dataTable = [String]()
                
                let randomInt = Int.random(in: 1..<responseJSON.count)
                if let flags = responseJSON[randomInt]["flags"] as? [String:Any]{
                    dataTable.append(flags["png"] as! String)
                }
                dataTable.append(responseJSON[randomInt]["name"] as! String)
                //print(responseJSON[randomInt]["name"])
                //print(responseJSON[randomInt]["capital"])
                
                //print(dataTable)

                //let dataName = data["name"] as? String
                
              //  let title = responseJSON[0]["name"] as? String
               // print(title)
                
                completion(dataTable, nil)
            } catch let error {
                os_log("Unexpected error during JSONSerialization: %@", log: OSLog.default, type: .error, error.localizedDescription)
                completion(nil, error)
            }
        }
        
        task.resume()
    
    }
    
    func getCountriesRandomCapital(completion: @escaping stringCompletion) {
        guard let urlSafe = URL(string: "\(Path.all)") else {
            os_log("Error: invalid url: %@", log: OSLog.default, type: .error, "\(Path.all)")
            completion(nil, RequestError.badFormatURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlSafe) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, RequestError.noResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                if response.statusCode == 404 {
                    os_log("No country matching the request was found", log: OSLog.default, type: .error)
                    completion([], nil)
                } else {
                    os_log("Unexpected response from the API: %@", log: OSLog.default, type: .error, response.debugDescription)
                    completion(nil, RequestError.invalidResponse)
                }
                return
            }
            
            guard let dataSafe = data else {
                os_log("Unexpected data from the API: %@", log: OSLog.default, type: .error, data.debugDescription)
                completion(nil, RequestError.invalidData)
                return
            }
            
            do {
                guard let responseJSON = try JSONSerialization.jsonObject(with: dataSafe, options: []) as? [[String: Any]] else {
                    os_log("Unexpected data format from the API: %@", log: OSLog.default, type: .error, dataSafe.debugDescription)
                    completion(nil, RequestError.invalidData)
                    return
                }
                
                
                var dataTable = [String]()
                
                let randomInt = Int.random(in: 1..<responseJSON.count)
                dataTable.append(responseJSON[randomInt]["name"] as! String)
                dataTable.append(responseJSON[randomInt]["capital"] as! String)
                //print(responseJSON[randomInt]["name"])
                //print(responseJSON[randomInt]["capital"])
                
                //print(dataTable)

                //let dataName = data["name"] as? String
                
              //  let title = responseJSON[0]["name"] as? String
               // print(title)
                
                completion(dataTable, nil)
            } catch let error {
                os_log("Unexpected error during JSONSerialization: %@", log: OSLog.default, type: .error, error.localizedDescription)
                completion(nil, error)
            }
        }
        
        task.resume()
    
    }
    
    func getCountryByName(countryName: String, completion: @escaping countryCompletion) {
        requestCountriesData(url: Path.name, queryParam: countryName) { response, error in
            completion(response, error)
        }
    }
    
    private func requestCountriesData(url: String, queryParam: String = "",
                                      completion: @escaping (_ response: [Country]?, _ error: Error?) -> Void) {
        
        guard let urlSafe = URL(string: "\(url)\(queryParam)") else {
            os_log("Error: invalid url: %@", log: OSLog.default, type: .error, "\(url)\(queryParam)")
            completion(nil, RequestError.badFormatURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlSafe) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, RequestError.noResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                if response.statusCode == 404 {
                    os_log("No country matching the request was found", log: OSLog.default, type: .error)
                    completion([], nil)
                } else {
                    os_log("Unexpected response from the API: %@", log: OSLog.default, type: .error, response.debugDescription)
                    completion(nil, RequestError.invalidResponse)
                }
                return
            }
            
            guard let dataSafe = data else {
                os_log("Unexpected data from the API: %@", log: OSLog.default, type: .error, data.debugDescription)
                completion(nil, RequestError.invalidData)
                return
            }
            
            do {
                guard let responseJSON = try JSONSerialization.jsonObject(with: dataSafe, options: []) as? [[String: Any]] else {
                    os_log("Unexpected data format from the API: %@", log: OSLog.default, type: .error, dataSafe.debugDescription)
                    completion(nil, RequestError.invalidData)
                    return
                }
                
                var countries = [Country]()
                
                for data in responseJSON {
                    if let country = Country(withJson: data) {
                        countries.append(country)
                    }
                }
                
                completion(countries, nil)
            } catch let error {
                os_log("Unexpected error during JSONSerialization: %@", log: OSLog.default, type: .error, error.localizedDescription)
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}
