//
//  ChatViewController.swift
//  MessageKit
//
//  Created by Nguyen Viet on 6/2/20.
//  Copyright © 2020 Nguyen Viet. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imageSelector: UIButton!
    @IBOutlet weak var _sender: UIButton!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var _inputView: UIView!
    
    let imgPicker = UIImagePickerController()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    var userID = Auth.auth().currentUser?.uid
    var buddy : User = User(userId: "", photoURL: "", name: "", status: false)
    var messages : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputText.delegate = self
        self.title = buddy.name
        loadMessage()
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
        imgPicker.delegate = self
        imgPicker.sourceType = .photoLibrary
        self.present(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        dismiss(animated: true, completion: nil)
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        let imgName = UUID().uuidString
        let imgRef = Storage.storage().reference().child("imgs").child(imgName)
        imgRef.putData(data, metadata: nil) { (metadata, err) in
            if let e = err{
                print(e.localizedDescription)
                return
            }
            imgRef.downloadURL { (url, error) in
                if let e = err{
                    print(e.localizedDescription)
                    return
                }
                
                guard let url = url else {
                    return
                }
                self.putMessage(message: "", photo: url.absoluteString)
                
            }
        }
        
    }
    
    
}

extension ChatViewController{
    
}

extension ChatViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let message = inputText.text else {
            return
        }
        putMessage(message: message, photo: "")
        
    }
    
    func putMessage(message : String, photo : String){
        db.collection("Messages").addDocument(data: ["sender":userID!,
                                                     "reciver":buddy.userId,
                                                     "message":message,
                                                     "photo": photo,
                                                     "time":Date().timeIntervalSince1970]){ (error) in
                                                        if let e = error{
                                                            print(e.localizedDescription)
                                                        }else{
                                                            print("put success")
                                                            DispatchQueue.main.async {
                                                                self.inputText.text = ""
                                                            }
                                                        }
        }
    }
    
    func loadMessage(){
        messages = []
        db.collection("Messages").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            for doc in documents{
                let data = doc.data()
                if let senderId = data["sender"] as? String, let receiver = data["reciver"] as? String, let message = data["message"] as? String, let photo = data["photo"] as? String
                {
                    if (senderId == self.userID && receiver == self.buddy.userId) || (senderId == self.buddy.userId && receiver == self.userID){
                        let _message = Message.init(sId: senderId, rId: receiver, message: message, photo: photo)
                        print(_message)
                        self.messages.append(_message)
                    }
                    
                    
                }
            }
            
        }
        //print(messages)
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


