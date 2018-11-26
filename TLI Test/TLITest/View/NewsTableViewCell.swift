//
//  NewsTableViewCell.swift
//  TLI Test
//
//  Created by Murali Gorantla on 22/11/18.
//  Copyright © 2018 Murali Gorantla. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class NewsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "newsCellIdentifier"
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.size.width / 2
        thumbnailImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = titleLabel {
                label.text = detail.title
            }
            
            if let label = authorLabel {
                label.text = detail.byLine
            }
            
            if let label = dateLabel {
                label.text = detail.publishDate
            }
            
            if let medias = detailItem?.media {
                if !(medias.isEmpty) {
                    let imageObject = medias[0].medias?.filter{ $0.format == "Standard Thumbnail" }.first // this need to change based on requirement
                    if let imageURL = imageObject?.url {
                        guard let url = URL(string: imageURL) else {
                            return
                        }
                        thumbnailImageView.af_setImage(withURL: url)
                    }
                }
            }
        }
    }
    
    var detailItem: News? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
}
