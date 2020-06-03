//
//  ChatViewController.swift
//  MessageKit
//
//  Created by Nguyen Viet on 6/2/20.
//  Copyright © 2020 Nguyen Viet. All rights reserved.
//

import UIKit


class ChatViewController: UIViewController{
    
    @IBOutlet weak var imageSelector: UIImageView!
    @IBOutlet weak var _sender: UIImageView!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var _inputView: UIView!
    var user : User = User(userId: "", photoURL: "", name: "", status: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = user.name
        drawBorder()
// Do any additional setup after loading the view.
    }
    
    func drawBorder(){
        let topBorderView = UIView(frame: CGRect(x: 0, y: 0,
                                                 width: self._inputView.frame.size.width,
                                                 height: 1))
        topBorderView.backgroundColor = UIColor.gray
        self._inputView.addSubview(topBorderView)

        
    }
    
    
    
}


