//
//  Currency.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

public struct Flag: CountryData, Codable {
    public var name: String
    public let png: String
    
    public init(name: String, png: String){
        self.name = name
        self.png = png
    }
    
    public static func getCountryData(json: [[String : Any]]?) -> [CountryData]? {
        guard let json = json else {
            return nil
        }
        
        var flags = [Flag]()
        for data in json {
            if let flag = Flag(withJson: data) {
                flags.append(flag)
            }
        }
        
        return flags.count > 0 ? flags : nil
    }
}

public extension Flag {
    public init?(withJson json: [String : Any]?) {
        guard let name = json?["name"] as? String,
            let png = json?["png"] as? String else {
                return nil
        }

        self.name = name
        self.png = png
    }
}
