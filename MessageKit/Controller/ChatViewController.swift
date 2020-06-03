//
//  ChatViewController.swift
//  MessageKit
//
//  Created by Nguyen Viet on 6/2/20.
//  Copyright © 2020 Nguyen Viet. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController{
    
    @IBOutlet weak var imageSelector: UIButton!
    @IBOutlet weak var _sender: UIButton!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var _inputView: UIView!
    
    let db = Firestore.firestore()
    var userID = Auth.auth().currentUser?.uid
    var user : User = User(userId: "", photoURL: "", name: "", status: false)
    var photoURL : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputText.delegate = self
        self.title = user.name
        drawBorder()
        dismissKey()
        // Do any additional setup after loading the view.
    }
    
    func drawBorder(){
        let topBorderView = UIView(frame: CGRect(x: 0, y: 0,
                                                 width: self._inputView.frame.size.width,
                                                 height: 1))
        topBorderView.backgroundColor = UIColor.gray
        self._inputView.addSubview(topBorderView)
        
        
    }
    
    @IBAction func sendPress(_ sender: UIButton) {
        inputText.endEditing(true)
    }
    @IBAction func imageSelectorPress(_ sender: UIButton) {
        
    }
    
    
}

extension ChatViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let message = inputText.text else {
            return
        }
        db.collection("Messages").addDocument(data: ["sender":userID!,
                                                     "reciver":user.userId,
                                                     "message":message,
                                                     "photo": photoURL,
                                                     "time":Date().timeIntervalSince1970]){ (error) in
                                                        if let e = error{
                                                            print(e.localizedDescription)
                                                        }else{
                                                            DispatchQueue.main.async {
                                                                self.inputText.text = ""
                                                            }
                                                        }
        }
        
        
    }
    
    func dismissKey()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    
}


