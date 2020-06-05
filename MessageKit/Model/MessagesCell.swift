//
//  MessagesCell.swift
//  MessageKit
//
//  Created by Nguyen Viet on 6/3/20.
//  Copyright © 2020 Nguyen Viet. All rights reserved.
//

import UIKit

class MessagesCell: UICollectionViewCell {
    @IBOutlet weak var buddyImg: UIImageView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var messageImg: UIImageView!
    @IBOutlet weak var messageText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
