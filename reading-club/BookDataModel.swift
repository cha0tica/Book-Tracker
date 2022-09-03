//
//  BookDataModel.swift
//  reading-club
//
//  Created by Agata on 07.08.2022.
//

import Foundation
import Alamofire

struct Books: Codable {
    let kind: String
    let totalItems: Int
    let items: [Item]

    enum CodingKeys: String, CodingKey {
            case kind, totalItems, items
    
    }
}

struct Item: Codable {
    let volumeInfo: VolumeInfo
    
    enum CodingKeys: String, CodingKey {
            case volumeInfo
    
    }
            }


struct VolumeInfo: Codable {
    let title: String
    let authors: [String]
    let imageLinks: ImageLinks?
    
    enum CodingKeys: String, CodingKey {
            case title, authors
            case imageLinks
}
}

struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case smallThumbnail, thumbnail
                    }
}


    

/*
struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    //let imageLinks: ImageLinks?
    let smallThumbnail: String? //делаем опциональное значение на случай, если нет картинки
    //let thumbnail: String
    
    
    enum CodingKeys: String, CodingKey {
            case title, authors
            //case volumeInfoDescription
            //case industryIdentifiers, readingModes, pageCount, printType, categories, averageRating, ratingsCount, maturityRating, allowAnonLogging, contentVersion, panelizationSummary, imageLinks, language, previewLink, infoLink, canonicalVolumeLink, publisher
        case smallThumbnail
        }
}

//struct ImageLinks: Codable {
//    let smallThumbnail: String
//    let thumbnail: String
//}
*/
