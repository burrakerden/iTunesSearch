// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct SearchApi: Codable {
    let resultCount: Int?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let trackName: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let releaseDate: String?
    let description: String?
    let longDescription: String?
    let artistName: String?
    
}
