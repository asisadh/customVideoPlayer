//
//  ListingViewInteractor.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/19/19.
//  Copyright © 2019 Smart Mobe. All rights reserved.
//

import Foundation

class ListingViewInteractor: ListingViewInteractorInputProtocol {
    
    var presenter: ListingViewInteractorOutputProtocol?
    var remoteDataManager: ListingViewRemoteDataManagerInputProtocol?
    
    func retriveVideoList() {
        retriveVideoListFormServer()
    }
    
    func searchVideoList(key: String) {
        retriveVideoListFormServer(query: key)
    }
    
    func paginateVideoList(nextPage: Int, key: String) {
        retriveVideoListFormServer(query: key, page: nextPage)
    }
    
    private func retriveVideoListFormServer(query: String = "", page: Int = 1){
        remoteDataManager?.retriveVideoList(request: ListRequestModel(query: query, page: page))
    }
}

extension ListingViewInteractor: ListingViewRemoteDataManagerOutputProtocol{
    func onVideoListRetrieved(model: ListResponseModel) {
        onVideoListRetrived(model: model, isFromPaginaged: false)
    }
    
    func onPaginatedVideoListReterived(model: ListResponseModel) {
        onVideoListRetrived(model: model, isFromPaginaged: true)
    }
    
    private func onVideoListRetrived(model: ListResponseModel, isFromPaginaged: Bool){
        if let listOfVideo = model.data,
            let currentPage = model.currentPage{
            if let _ = model.nextPageURL{
                presenter?.didRetriveData(list: listOfVideo, currentPage: currentPage, didReachEndOfList: false, isPaginatedData: isFromPaginaged)
            }else{
                presenter?.didRetriveData(list: listOfVideo, currentPage: currentPage, didReachEndOfList: true, isPaginatedData: isFromPaginaged)
            }
        }else{
            presenter?.onError(message: "Something went wrong")
        }
    }
    
    func onError(message: String) {
        presenter?.onError(message: message)
    }
}
