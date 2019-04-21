//
//  ListingViewProtocols.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/19/19.
//  Copyright © 2019 Smart Mobe. All rights reserved.
//

import Foundation
import UIKit
import CoreMedia

protocol ListingViewProtocol: class{
    var presenter: ListingViewPresenterProtocol? {get set}
    
    func showLoading()
    func hideLoading()
    func refreshView()
    func playViewInMiniView(source: String, time: CMTime)
}

protocol ListingViewPresenterProtocol: class{
    var view: ListingViewProtocol? {get set}
    var interactor: ListingViewInteractorInputProtocol? {get set}
    var wireFrame: ListingViewWireFrameProtocol? {get set}
    
    var currentPage: Int {get set}
    var numberOfVideos: Int {get set}
    var listOfVideos:[ListResponseData] { get set}
    var didReachEndOfList: Bool {get set}
    
    func viewDidLoad()
    func viewUpdatedVideoList()
    func viewSearchedVideoList(key:String)
    func viewFetchPaginatedVideoList(key: String)
    
    func showVideoDetail(video: ListResponseData)
    func showError(message: String)
    
    func video(at row: Int) -> ListResponseData
}

protocol ListingViewInteractorInputProtocol: class{
    var presenter: ListingViewInteractorOutputProtocol? {get set}
    var remoteDataManager: ListingViewRemoteDataManagerInputProtocol? {get set}
    
    func retriveVideoList()
    func searchVideoList(key: String)
    func paginateVideoList(nextPage: Int, key: String)
}

protocol ListingViewInteractorOutputProtocol: class{
    func didRetriveData(list: [ListResponseData], currentPage: Int, didReachEndOfList: Bool, isPaginatedData: Bool)
    func onError(message: String)
}

protocol ListingViewRemoteDataManagerInputProtocol: class{
    var requestHandler: ListingViewRemoteDataManagerOutputProtocol? {get set}
    func retriveVideoList(request: ListRequestModel)
}

protocol ListingViewRemoteDataManagerOutputProtocol: class{
    func onVideoListRetrieved(model: ListResponseModel)
    func onPaginatedVideoListReterived(model: ListResponseModel)
    func onError(message: String)
}

protocol ListingViewWireFrameProtocol: class{
    static func createVideoListingViewModule() -> UIViewController
    
    func presentVideoDetailScreen(from view: ListingViewProtocol, forVideo video: ListResponseData, delegate: VideoDetailViewDelegate)
    func presentErrorScreen(from view: ListingViewProtocol, errorMessage message: String)
}
