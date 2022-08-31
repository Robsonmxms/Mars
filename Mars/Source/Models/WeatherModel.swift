// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherModel = try? newJSONDecoder().decode(WeatherModel.self, from: jsonData)

import Foundation
// swiftlint:disable identifier_name

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let soles: [Sole]
}

// MARK: - Sole
struct Sole: Codable {
    let id, terrestrialDate, sol: String
    let minTemp, maxTemp: String

    enum CodingKeys: String, CodingKey {
        case id
        case terrestrialDate = "terrestrial_date"
        case sol
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
    }
}
