//
//  CountryData.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

public protocol CountryData {
    var name: String { get }
    static func getCountryData(json: [[String: Any]]?) -> [CountryData]?
}
