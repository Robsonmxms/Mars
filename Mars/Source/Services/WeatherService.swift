//
//  WeatherServices.swift
//  Mars
//
//  Created by Robson Lima Lopes on 25/08/22.
//

import Foundation

struct WeatherServiceConstants {
    static let constUrl = "https://mars.nasa.gov/rss/api/?feed=weather&category=msl&feedtype=json"
}
struct WeatherService {
    func getWeatherInfo() async throws -> WeatherModel? {
        let getUrl = URL(string: WeatherServiceConstants.constUrl)
        do {
            let (data, _) = try await URLSession.shared.data(from: getUrl!)
            let jsonDecode = try JSONDecoder().decode(WeatherModel.self, from: data)
            return jsonDecode
        } catch {
            print(error)
        }
        return nil
    }
}
