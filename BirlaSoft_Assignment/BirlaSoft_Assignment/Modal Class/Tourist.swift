//
//  Employee.swift
//  BirlaSoft_Assignment
//
//  Created by Krishna Gunjal on 16/06/22.
//

import Foundation

// MARK: - Employee
struct Tourist: Codable {
    let page, perPage, totalrecord, totalPages: Int
    let data: [TouristDetails]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalrecord
        case totalPages = "total_pages"
        case data
    }
}

// MARK: - TouristDetails
struct TouristDetails: Codable {
    let id: Int
    let touristName, touristEmail, touristLocation, createdat: String

    enum CodingKeys: String, CodingKey {
        case id
        case touristName = "tourist_name"
        case touristEmail = "tourist_email"
        case touristLocation = "tourist_location"
        case createdat
    }
}
