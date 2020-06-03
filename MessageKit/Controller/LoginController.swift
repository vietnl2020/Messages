//
//  LoginControllerViewController.swift
//  MessageKit
//
//  Created by Nguyen Viet on 6/2/20.
//  Copyright © 2020 Nguyen Viet. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInPress(_ sender: UIButton) {
        if let email = usernameTxt.text, let password = passwordTxt.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error{
                    print(e)
                }else{
                    self?.performSegue(withIdentifier: "ToMainScreen", sender: self)
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
