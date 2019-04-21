//
//  VideoDetailWireFrame.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/21/19.
//  Copyright © 2019 Aashish Adhikari. All rights reserved.
//

import Foundation
import UIKit

class VideoDetailWireFrame: VideoDetailViewWireFrameProtocol{
    static func createVideoDetailViewModule(video: ListResponseData, videoList: [ListResponseData], delegate: VideoDetailViewDelegate) -> UIViewController {
        let vc = VideoDetailView.instantiate(from: .Video)
        let view = vc as VideoDetailViewProtocol
        let presenter: VideoDetailViewPresenterProtocol = VideoDetailViewPresenter(video: video, videoList: videoList, delegate: delegate)
        let wireFrame: VideoDetailViewWireFrameProtocol = VideoDetailWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        
        return vc
    }
}
