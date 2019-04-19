//
//  ListingViewPresenter.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/19/19.
//  Copyright © 2019 Smart Mobe. All rights reserved.
//

import Foundation

class ListingViewPresenter: ListingViewPresenterProtocol{
    
    var view: ListingViewProtocol?
    var interactor: ListingViewInteractorInputProtocol?
    var wireFrame: ListingViewWireFrameProtocol?
    
    var currentPage: Int = 1
    var numberOfVideos: Int = 0
    var listOfVideos: [ListResponseData] = []
    var didReachEndOfList: Bool =  false
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retriveVideoList()
    }
    
    func viewUpdatedVideoList() {
        interactor?.retriveVideoList()
    }
    
    func viewSearchedVideoList(key: String) {
        view?.showLoading()
        interactor?.searchVideoList(key: key)
    }
    
    func viewFetchPaginatedVideoList(key: String) {
        interactor?.paginateVideoList(nextPage: currentPage + 1, key: key)
    }
    
    func video(at row: Int) -> ListResponseData {
        return listOfVideos[row]
    }
    
    func showVideoDetail(video: ListResponseData) {
        if let view = view{
            wireFrame?.presentVideoDetailScreen(from: view, forVideo: video)
        }
    }
    
    func showError(message: String) {
        if let view = view{
            wireFrame?.presentErrorScreen(from: view, errorMessage: message)
        }
    }
}

extension ListingViewPresenter: ListingViewInteractorOutputProtocol{
    
    func didRetriveData(list: [ListResponseData], currentPage: Int, didReachEndOfList: Bool, isPaginatedData: Bool) {
        if isPaginatedData{
            self.listOfVideos.append(contentsOf: list)
        }else{
            self.listOfVideos = list
        }
        numberOfVideos = listOfVideos.count
        self.didReachEndOfList = didReachEndOfList
        self.currentPage = currentPage
        view?.refreshView()
    }
    
    func onError(message: String) {
        view?.hideLoading()
        showError(message: message)
    }
}
