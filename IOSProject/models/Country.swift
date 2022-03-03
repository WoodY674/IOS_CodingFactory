//
//  Country.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

import CoreLocation

public struct Country: Codable {
    public let name: String
    public let population: Int
    public let alpha3Code: String
    public let flag: String
    public let capital: String
    public let region: String
    public var currencies: [Currency]?
    
    public init(alpha3Code: String, name: String, population: Int, flag: String, capital: String, region: String) {
        self.name = name
        self.alpha3Code = alpha3Code
        self.population = population
        self.flag = flag
        self.capital = capital
        self.region = region
    }
}

public extension Country {
    public init?(withJson json: [String : Any]?) {
        guard let name = json?["name"] as? String,
            let population = json?["population"] as? Int,
            let capital = json?["capital"] as? String,
            let region = json?["region"] as? String,
            let flag = json?["flag"] as? String,
            let alpha3Code = json?["alpha3Code"] as? String else {
                return nil
            }
        
        self.population = population
        self.name = name
        self.alpha3Code = alpha3Code
        self.flag = flag
        self.capital = capital
        self.region = region
        self.currencies = Currency.getCountryData(json: json?["currencies"] as? [[String: Any]]) as? [Currency]
    }
}
