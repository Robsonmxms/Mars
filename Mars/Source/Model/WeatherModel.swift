// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherModel = try? newJSONDecoder().decode(WeatherModel.self, from: jsonData)

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let descriptions: Descriptions
    let soles: [Sole]
}

// MARK: - Descriptions
struct Descriptions: Codable {
    let disclaimerEn, disclaimerEs, solDescEn, solDescEs: String
    let terrestrialDateDescEn, terrestrialDateDescEs, tempDescEn, tempDescEs: String
    let pressureDescEn, pressureDescEs, absHumidityDescEn, absHumidityDescEs: String
    let windDescEn, windDescEs, gtsTempDescEn, gtsTempDescEs: String
    let localUvIrradianceIndexDescEn, localUvIrradianceIndexDescEs, atmoOpacityDescEn, atmoOpacityDescEs: String
    let lsDescEn, lsDescEs, seasonDescEn, seasonDescEs: String
    let sunriseSunsetDescEn, sunriseSunsetDescEs: String

    enum CodingKeys: String, CodingKey {
        case disclaimerEn = "disclaimer_en"
        case disclaimerEs = "disclaimer_es"
        case solDescEn = "sol_desc_en"
        case solDescEs = "sol_desc_es"
        case terrestrialDateDescEn = "terrestrial_date_desc_en"
        case terrestrialDateDescEs = "terrestrial_date_desc_es"
        case tempDescEn = "temp_desc_en"
        case tempDescEs = "temp_desc_es"
        case pressureDescEn = "pressure_desc_en"
        case pressureDescEs = "pressure_desc_es"
        case absHumidityDescEn = "abs_humidity_desc_en"
        case absHumidityDescEs = "abs_humidity_desc_es"
        case windDescEn = "wind_desc_en"
        case windDescEs = "wind_desc_es"
        case gtsTempDescEn = "gts_temp_desc_en"
        case gtsTempDescEs = "gts_temp_desc_es"
        case localUvIrradianceIndexDescEn = "local_uv_irradiance_index_desc_en"
        case localUvIrradianceIndexDescEs = "local_uv_irradiance_index_desc_es"
        case atmoOpacityDescEn = "atmo_opacity_desc_en"
        case atmoOpacityDescEs = "atmo_opacity_desc_es"
        case lsDescEn = "ls_desc_en"
        case lsDescEs = "ls_desc_es"
        case seasonDescEn = "season_desc_en"
        case seasonDescEs = "season_desc_es"
        case sunriseSunsetDescEn = "sunrise_sunset_desc_en"
        case sunriseSunsetDescEs = "sunrise_sunset_desc_es"
    }
}

// MARK: - Sole
struct Sole: Codable {
    let id, terrestrialDate, sol, ls: String
    let season: Season
    let minTemp, maxTemp, pressure: String
    let pressureString, absHumidity, windSpeed, windDirection: AbsHumidity
    let atmoOpacity: AtmoOpacity
    let sunrise, sunset: String
    let localUvIrradianceIndex: LocalUvIrradianceIndex
    let minGtsTemp, maxGtsTemp: String

    enum CodingKeys: String, CodingKey {
        case id
        case terrestrialDate = "terrestrial_date"
        case sol, ls, season
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case pressure
        case pressureString = "pressure_string"
        case absHumidity = "abs_humidity"
        case windSpeed = "wind_speed"
        case windDirection = "wind_direction"
        case atmoOpacity = "atmo_opacity"
        case sunrise, sunset
        case localUvIrradianceIndex = "local_uv_irradiance_index"
        case minGtsTemp = "min_gts_temp"
        case maxGtsTemp = "max_gts_temp"
    }
}

enum AbsHumidity: String, Codable {
    case empty = "--"
    case higher = "Higher"
    case lower = "Lower"
}

enum AtmoOpacity: String, Codable {
    case empty = "--"
    case sunny = "Sunny"
}

enum LocalUvIrradianceIndex: String, Codable {
    case empty = "--"
    case high = "High"
    case low = "Low"
    case moderate = "Moderate"
    case veryHigh = "Very_High"
}

enum Season: String, Codable {
    case month1 = "Month 1"
    case month10 = "Month 10"
    case month11 = "Month 11"
    case month12 = "Month 12"
    case month2 = "Month 2"
    case month3 = "Month 3"
    case month4 = "Month 4"
    case month5 = "Month 5"
    case month6 = "Month 6"
    case month7 = "Month 7"
    case month8 = "Month 8"
    case month9 = "Month 9"
}


