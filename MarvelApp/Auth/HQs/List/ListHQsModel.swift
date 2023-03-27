//
//  ListHQsModel.swift
//  MarvelApp
//
//  Created by TLSP-000161 on 23/03/23.
//

import Foundation

// MARK: - HQs
struct HQs: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: DataClass
    let etag: String?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case status = "status"
        case copyright = "copyright"
        case attributionText = "attributionText"
        case attributionHTML = "attributionHTML"
        case data = "data"
        case etag = "etag"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [HQ]

    enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case results = "results"
    }
}

// MARK: - Result
struct HQ: Codable {
    let id: Int?
    let digitalID: Int?
    let title: String?
    let issueNumber: Int?
    let variantDescription: String?
    let description: String?
    let modified: String?
    let isbn: String?
    let upc: String?
    let diamondCode: String?
    let ean: String?
    let issn: String?
    let format: String?
    let pageCount: Int?
    let textObjects: [TextObject]?
    let resourceURI: String?
    let urls: [URLElement]?
    let series: Series?
    let variants: [Series]?
    let collections: [Series]?
    let collectedIssues: [Series]?
    let dates: [DateElement]?
    let prices: [Price]?
    let thumbnail: Thumbnail?
    let images: [Thumbnail]?
    let creators: Characters?
    let characters: Characters?
    let stories: Stories?
    let events: Events?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case digitalID = "digitalId"
        case title = "title"
        case issueNumber = "issueNumber"
        case variantDescription = "variantDescription"
        case description = "description"
        case modified = "modified"
        case isbn = "isbn"
        case upc = "upc"
        case diamondCode = "diamondCode"
        case ean = "ean"
        case issn = "issn"
        case format = "format"
        case pageCount = "pageCount"
        case textObjects = "textObjects"
        case resourceURI = "resourceURI"
        case urls = "urls"
        case series = "series"
        case variants = "variants"
        case collections = "collections"
        case collectedIssues = "collectedIssues"
        case dates = "dates"
        case prices = "prices"
        case thumbnail = "thumbnail"
        case images = "images"
        case creators = "creators"
        case characters = "characters"
        case stories = "stories"
        case events = "events"
    }
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [CharactersItem]?

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case returned = "returned"
        case collectionURI = "collectionURI"
        case items = "items"
    }
}

// MARK: - CharactersItem
struct CharactersItem: Codable {
    let resourceURI: String?
    let name: String?
    let role: String?

    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
        case role = "role"
    }
}

// MARK: - Series
struct Series: Codable {
    let resourceURI: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
    }
}

// MARK: - DateElement
struct DateElement: Codable {
    let type: String?
    let date: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case date = "date"
    }
}

// MARK: - Events
struct Events: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [Series]?

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case returned = "returned"
        case collectionURI = "collectionURI"
        case items = "items"
    }
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path = "path"
        case thumbnailExtension = "extension"
    }
}

// MARK: - Price
struct Price: Codable {
    let type: String?
    let price: Double?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case price = "price"
    }
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [StoriesItem]?

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case returned = "returned"
        case collectionURI = "collectionURI"
        case items = "items"
    }
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
        case type = "type"
    }
}

// MARK: - TextObject
struct TextObject: Codable {
    let type: String?
    let language: String?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case language = "language"
        case text = "text"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
    }
}
