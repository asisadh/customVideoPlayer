//
//  ListingViewTableCellView.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/19/19.
//  Copyright © 2019 Smart Mobe. All rights reserved.
//

import UIKit
import SDWebImage

class ListingViewTableCellView: UITableViewCell{
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var uploaderImageView: UIImageView!
    
    func setup(data: ListResponseData){
        
        if let thumbnailUrl = data.thumbnail,
            let title = data.title,
            let views = data.views,
            let uploadedBy = data.uploadedBy,
            let uploadedOn = data.uploadedOn,
            let uploaderImage = data.uploaderImage
            {
            titleLabel.text = title
//            thumbnailImageView?.sd_setImage(with: URL(string: thumbnailUrl),placeholderImage: UIImage(named: ""))
            thumbnailImageView.image = UIImage(named: thumbnailUrl)
            descriptionLabel.text = uploadedBy + " ● " + String(views) + " views" + " ● " + uploadedOn
            uploaderImageView.image = UIImage(named: uploaderImage)
        }
    }
    
}
