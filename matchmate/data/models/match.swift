//
//  match.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//

// To parse the JSON, add this file to your project and do:
//
//   let match = try? JSONDecoder().decode(Match.self, from: jsonData)

import Foundation

// MARK: - Match
struct Match: Codable, Equatable {
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let login: Login?
    let dob, registered: Dob?
    let phone, cell: String?
    let id: ID?
    let picture: Picture?
    let nat: String?
    
    static func == (lhs: Match, rhs: Match) -> Bool {
        return lhs.gender == rhs.gender &&
        lhs.name == rhs.name &&
        lhs.location == rhs.location &&
        lhs.email == rhs.email &&
        lhs.login == rhs.login &&
        lhs.dob == rhs.dob &&
        lhs.registered == rhs.registered &&
        lhs.phone == rhs.phone &&
        lhs.cell == rhs.cell &&
        lhs.id == rhs.id &&
        lhs.picture == rhs.picture &&
        lhs.nat == rhs.nat
    }
}

// MARK: - Dob
struct Dob: Codable, Equatable {
    let date: String?
    let age: Int?
}

// MARK: - ID
struct ID: Codable, Equatable {
    let name, value: String?
}

// MARK: - Location
struct Location: Codable, Equatable {
    let street: Street?
    let city, state, country: String?
    //    let postcode: Int?
    let coordinates: Coordinates?
    let timezone: Timezone?
}

// MARK: - Coordinates
struct Coordinates: Codable, Equatable {
    let latitude, longitude: String?
}

// MARK: - Street
struct Street: Codable, Equatable {
    let number: Int?
    let name: String?
}

// MARK: - Timezone
struct Timezone: Codable, Equatable {
    let offset, description: String?
}

// MARK: - Login
struct Login: Codable, Equatable {
    let uuid, username, password, salt: String?
    let md5, sha1, sha256: String?
}

// MARK: - Name
struct Name: Codable, Equatable {
    let title, first, last: String?
}

// MARK: - Picture
struct Picture: Codable, Equatable {
    let large, medium, thumbnail: String?
}
