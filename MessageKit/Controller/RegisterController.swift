//
//  RegisterController.swift
//  MessageKit
//
//  Created by Nguyen Viet on 5/26/20.
//  Copyright © 2020 Nguyen Viet. All rights reserved.
//

import UIKit
import Firebase
class RegisterController: UIViewController {
    
    let db = Firestore.firestore()
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpPress(_ sender: UIButton) {
        if let email = usernameTxt.text, let password = passwordTxt.text, let name = nameTxt.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    if let currentUser = Auth.auth().currentUser{
                        // Add a new document in collection "cities"
                        self.db.collection("users").addDocument(data: [
                            "uid": currentUser.uid,
                            "email" : currentUser.email!,
                            "name" : name,
                            "photo" : ("https://thumbs.dreamstime.com/b/default-avatar-profile-icon-social-media-user-vector-default-avatar-profile-icon-social-media-user-vector-portrait-176194876.jpg"),
                            "status": false
                            
                            
                        ])
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
            
            
        }
        
        
        
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
