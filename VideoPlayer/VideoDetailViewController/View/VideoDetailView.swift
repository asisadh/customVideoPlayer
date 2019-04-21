//
//  VideoDetailView.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/21/19.
//  Copyright © 2019 Aashish Adhikari. All rights reserved.
//

import UIKit
import AVKit

class VideoDetailView: UIViewController{
    
    var presenter: VideoDetailViewPresenterProtocol?
    
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var uploaderImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var containerView: VideoPlayerView!
    
    private let identifier = "ListingViewTableCellView"
    
    var currentPlayingSource: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.delegate.playBackVideoInMiniView(source: currentPlayingSource, time: containerView.currentTime)
    }
}

extension VideoDetailView: VideoDetailViewProtocol{
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func refreshView() {
        if let data = presenter?.video{
            if let thumbnailUrl = data.thumbnail,
                let title = data.title,
                let views = data.views,
                let source = data.source,
                let uploadedBy = data.uploadedBy,
                let uploadedOn = data.uploadedOn,
                let uploaderImage = data.uploaderImage{
                titleLabel.text = title
                //            thumbnailImageView?.sd_setImage(with: URL(string: thumbnailUrl),placeholderImage: UIImage(named: ""))
                imagePreview.image = UIImage(named: thumbnailUrl)
                detailLabel.text = uploadedBy + " ● " + String(views) + " views" + " ● " + uploadedOn
                uploaderImageView.image = UIImage(named: uploaderImage)
                containerView.configure(url: source)
                containerView.play()
                currentPlayingSource = source
            }
        }
    }
    
}

extension VideoDetailView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = presenter?.numberOfVideos{
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ListingViewTableCellView
        
        if let data = presenter?.video(at: indexPath.row){
            cell.setup(data: data)
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        containerView.stop()
        if let data = presenter?.video(at: indexPath.row){
            if let thumbnailUrl = data.thumbnail,
                let title = data.title,
                let views = data.views,
                let source = data.source,
                let uploadedBy = data.uploadedBy,
                let uploadedOn = data.uploadedOn,
                let uploaderImage = data.uploaderImage{
                titleLabel.text = title
                imagePreview.image = UIImage(named: thumbnailUrl)
                detailLabel.text = uploadedBy + " ● " + String(views) + " views" + " ● " + uploadedOn
                uploaderImageView.image = UIImage(named: uploaderImage)
                containerView.configure(url: source)
                containerView.play()
                currentPlayingSource = source
            }
        }
    }
}
