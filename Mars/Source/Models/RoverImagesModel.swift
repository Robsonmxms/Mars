// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let roverImagesModel = try? newJSONDecoder().decode(RoverImagesModel.self, from: jsonData)

import Foundation

// MARK: - RoverImagesModel
struct RoverImagesModel: Codable {
    let photos: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id: Int
    let camera: Camera
    let imgSrc: String

    enum CodingKeys: String, CodingKey {
        case id, camera
        case imgSrc = "img_src"
    }
}

// MARK: - Camera
struct Camera: Codable {
    let id: Int
    let name: String
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case fullName = "full_name"
    }
}

enum CameraFullName: String, CaseIterable, Codable, Hashable {
    case chemistryAndCameraComplex = "Chemistry and Camera Complex"
    case frontHazardAvoidanceCamera = "Front Hazard Avoidance Camera"
    case mastCamera = "Mast Camera"
    case navigationCamera = "Navigation Camera"
    case rearHazardAvoidanceCamera = "Rear Hazard Avoidance Camera"
}

enum CameraName: String, Codable {
    case chemcam = "CHEMCAM"
    case fhaz = "FHAZ"
    case mast = "MAST"
    case navcam = "NAVCAM"
    case rhaz = "RHAZ"
}

struct CameraModel {
    static var cameraWasChanged = true
    static var camera: CameraName = .chemcam
    static func getAllPhotos(_ camera: CameraName) async -> [Photo] {
        let service = ImagesService()
        var model: RoverImagesModel?
        do {
            try await model = service.getImagesFromCamera(camera)
            cameraWasChanged = false
        } catch {
            print(error)
        }
        return model?.photos ?? []
    }
}
