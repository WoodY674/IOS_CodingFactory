//
//  Error.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

public enum RequestError: Error {
    case badFormatURL
    case noResponse
    case invalidResponse
    case invalidData
}
