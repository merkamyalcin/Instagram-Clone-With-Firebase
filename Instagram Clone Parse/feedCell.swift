//
//  feedCell.swift
//  Instagram Clone Parse
//
//  Created by Murat Erkam Yalçın on 27.08.2017.
//  Copyright © 2017 Murat Erkam Yalçın. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {

    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postCommentText: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        uuidLabel.isHidden = true
    }

  
}
