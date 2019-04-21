//
//  VideoDetailPresenter.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/21/19.
//  Copyright © 2019 Aashish Adhikari. All rights reserved.
//

import Foundation

class VideoDetailViewPresenter: VideoDetailViewPresenterProtocol{
    
    var view: VideoDetailViewProtocol?
    var wireFrame: VideoDetailViewWireFrameProtocol?
    var video: ListResponseData
    var delegate: VideoDetailViewDelegate
    
    init(video: ListResponseData, delegate: VideoDetailViewDelegate) {
        self.video = video
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        // do some task for model and other if needed
        view?.refreshView()
    }
}
