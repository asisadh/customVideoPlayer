//
//  ListResponseModel.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/19/19.
//  Copyright © 2019 Smart Mobe. All rights reserved.
//

import Foundation

struct ListResponseModel: Codable {
    let total, perPage, currentPage, lastPage: Int?
    let nextPageURL: String?
    let prevPageURL: String?
    let from, to: Int?
    let data: [ListResponseData]?
    
    enum CodingKeys: String, CodingKey {
        case total
        case perPage = "per_page"
        case currentPage = "current_page"
        case lastPage = "last_page"
        case nextPageURL = "next_page_url"
        case prevPageURL = "prev_page_url"
        case from, to, data
    }
}

struct ListResponseData: Codable {
    let id: Int?
    let title, source: String?
    let views: Int?
    let uploadedBy, uploadedOn: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, source, views
        case uploadedBy = "uploaded_by"
        case uploadedOn = "uploaded_on"
    }
}
