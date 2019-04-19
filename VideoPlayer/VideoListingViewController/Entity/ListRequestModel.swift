//
//  ListRequestModel.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/19/19.
//  Copyright © 2019 Smart Mobe. All rights reserved.
//

import Foundation

struct ListRequestModel{
    var query: String
    var page: Int
}

extension ListRequestModel{
    var paramaters: [String: Any]{
        return [
            "query": query,
            "page": page
        ]
    }
}
