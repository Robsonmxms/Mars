//
//  Constants.swift
//  Mars
//
//  Created by Robson Lima Lopes on 25/08/22.
//

import Foundation

struct ImagesServiceConstants {
    static let base_url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&"
    static let api_key = "DEMO_KEY"
}


struct ImagesService{
    
    func getImagesFromCamera(_ camera: CameraName) async throws -> RoverImagesModel? {
        let url = URL(string: "\(ImagesServiceConstants.base_url)api_key=\(ImagesServiceConstants.api_key)&camera=\(camera.rawValue)")
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url!)
            let jsonDecode = try JSONDecoder().decode(RoverImagesModel.self, from: data)
            
            return jsonDecode
        } catch {
            print(error)
        }
        return nil
    }
}
