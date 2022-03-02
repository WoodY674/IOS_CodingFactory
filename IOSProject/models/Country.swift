//
//  Country.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

import Foundation
import UIKit

struct Country: Decodable {
    
    let cca2: String
    let name: Name
    let capital: [String]?
    let population: Int
    let flags: Flag

}

struct Name: Codable {
    let common: String
    let official: String
}

struct Flag: Codable {
    let png: String
}
