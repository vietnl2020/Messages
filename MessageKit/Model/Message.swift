//
//  Message.swift
//  MessageKit
//
//  Created by VietNguyen on 6/5/20.
//  Copyright © 2020 Nguyen Viet. All rights reserved.
//

import Foundation
import UIKit

struct Message {
    let senderId : String
    let receiverId : String
    let message : String
    var photo : UIImage?
    
    init(sId : String, rId: String, message : String, photo: String) {
        print(photo)
        self.senderId = sId
        self.receiverId = rId
        self.message = message
        self.photo = nil
        
        if photo.isEmpty{
            return
        }
        
        let url = URL(fileURLWithPath: photo)
        if let data = try? Data(contentsOf: url)
        {
            let img: UIImage = UIImage(data: data)!
            self.photo = img
        }
        
    }
}
