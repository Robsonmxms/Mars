//
//  WeatherServices.swift
//  Mars
//
//  Created by Robson Lima Lopes on 25/08/22.
//

import Foundation

struct WeatherServiceConstants {
    static let base_url = "https://mars.nasa.gov/rss/api/?feed=weather&category=msl&feedtype=json"
}


struct WeatherService{
    func getWeatherInfo()async throws -> WeatherModel?{
        let url = URL(string: WeatherServiceConstants.base_url)
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url!)
            let jsonDecode = try JSONDecoder().decode(WeatherModel.self, from: data)
            
            return jsonDecode
        } catch {
            print(error)
        }
        return nil
    }
}

