// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let areas = try? newJSONDecoder().decode(Areas.self, from: jsonData)

import Foundation

// MARK: - Area
struct Area: Codable {
    let id: String
    let parentID: String?
    let name: String
    var areas: [Area]

    enum CodingKeys: String, CodingKey {
        case id
        case parentID = "parent_id"
        case name, areas
    }
}

typealias Areas = [Area]
