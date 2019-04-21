//
//  VideoDetailPresenter.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/21/19.
//  Copyright © 2019 Aashish Adhikari. All rights reserved.
//

import Foundation

class VideoDetailViewPresenter: VideoDetailViewPresenterProtocol{
    var numberOfVideos: Int
    
    var listOfVideos: [ListResponseData]
    
    
    var view: VideoDetailViewProtocol?
    var wireFrame: VideoDetailViewWireFrameProtocol?
    var video: ListResponseData
    var delegate: VideoDetailViewDelegate
    
    init(video: ListResponseData, videoList: [ListResponseData], delegate: VideoDetailViewDelegate) {
        self.video = video
        self.delegate = delegate
        listOfVideos = videoList
        numberOfVideos = listOfVideos.count
    }
    
    func video(at row: Int) -> ListResponseData {
        return listOfVideos[row]
    }
    
    func viewDidLoad() {
        // do some task for model and other if needed
        view?.refreshView()
    }
}
