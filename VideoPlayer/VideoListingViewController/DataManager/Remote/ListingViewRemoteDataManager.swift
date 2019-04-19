//
//  ListingViewRemoteDataManager.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/19/19.
//  Copyright © 2019 Smart Mobe. All rights reserved.
//

import Foundation
import Alamofire

class ListingViewRemoteDataManager: ListingViewRemoteDataManagerInputProtocol{
    
    // Request Handler sends the response back to Interactor
    var requestHandler: ListingViewRemoteDataManagerOutputProtocol?
    
    func retriveVideoList(request: ListRequestModel) {
        Alamofire
            .request(EndPoints.listingAPI.url, method: .get, parameters: request.paramaters)
            .validate()
            .responseListResponseModel { response in
                switch response.result{
                case .success(let listResponseModel):
                    #warning("we could check here the response of api, by compairing status code and status message.")
                    if let currentPage = listResponseModel.currentPage,
                        currentPage > 1{
                        self.requestHandler?.onPaginatedVideoListReterived(model: listResponseModel)
                    }else{
                        self.requestHandler?.onVideoListRetrieved(model: listResponseModel)
                    }
                case .failure(let error):
                    self.requestHandler?.onError(message: error.localizedDescription)
                }
        }
    }
}
