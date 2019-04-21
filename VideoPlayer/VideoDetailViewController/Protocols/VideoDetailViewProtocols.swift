//
//  VideoDetailViewProtocols.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/21/19.
//  Copyright © 2019 Aashish Adhikari. All rights reserved.
//

import Foundation
import UIKit
import CoreMedia

protocol VideoDetailViewProtocol: class{
    var presenter: VideoDetailViewPresenterProtocol? {get set}
    
    func showLoading()
    func hideLoading()
    func refreshView()
}

protocol VideoDetailViewPresenterProtocol: class{
    var view: VideoDetailViewProtocol? {get set}
    var wireFrame: VideoDetailViewWireFrameProtocol? {get set}
    
    var video: ListResponseData { get }
    var delegate: VideoDetailViewDelegate { get }
    
    func viewDidLoad()
}

protocol VideoDetailViewWireFrameProtocol: class{
    static func createVideoDetailViewModule(video: ListResponseData, delegate: VideoDetailViewDelegate) -> UIViewController
}

protocol VideoDetailViewDelegate: class{
    func playBackVideoInMiniView(source: String?, time: CMTime?)
}
