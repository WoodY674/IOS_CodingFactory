//
//  Country.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

import Foundation

struct Country: Codable, Hashable {
    var code: String
    var name: String
    var monnaie: String
    var capitale: String
    var continent: String
    var flag: String
    var positionGMaps: String
    var population: Int32
}
