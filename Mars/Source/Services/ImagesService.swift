//
//  Constants.swift
//  Mars
//
//  Created by Robson Lima Lopes on 25/08/22.
//

import Foundation

struct ImagesServiceConstants {
    static let constURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&"
    static let apiKey = "DEMO_KEY"
}

struct ImagesService {
    func getImagesFromCamera(_ camera: CameraName) async throws -> RoverImagesModel? {
        var urlToRequisition: String = ImagesServiceConstants.constURL
        urlToRequisition.append(contentsOf: "api_key=")
        urlToRequisition.append(contentsOf: ImagesServiceConstants.apiKey)
        urlToRequisition.append(contentsOf: "&camera=")
        urlToRequisition.append(contentsOf: camera.rawValue)
        let getUrl = URL(string: urlToRequisition)
        do {
            let (data, _) = try await URLSession.shared.data(from: getUrl!)
            let jsonDecode = try JSONDecoder().decode(RoverImagesModel.self, from: data)
            return jsonDecode
        } catch {
            print(error)
        }
        return nil
    }
}
