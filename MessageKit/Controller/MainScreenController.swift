//
//  MainScreenController.swift
//  MessageKit
//
//  Created by Nguyen Viet on 6/2/20.
//  Copyright © 2020 Nguyen Viet. All rights reserved.
//

import UIKit
import Firebase

class MainScreenController: UIViewController{
    
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    var users : [User] = []
    var desinationUserId : User = User(userId: "", photoURL: "", name: "", status: false)
    
    
    
    @IBOutlet weak var onlineCollectionView: UICollectionView!
    @IBOutlet weak var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        onlineCollectionView.delegate = self
        onlineCollectionView.dataSource = self
        onlineCollectionView.register(UINib(nibName: "OnlineUserCell", bundle: nil), forCellWithReuseIdentifier: "OnlineUserCell")
        getOnlineUser()
        
        updateUserStatus(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        updateUserStatus(false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gotoChat"{
            let desVC = segue.destination as! ChatViewController
            desVC.user = desinationUserId
            
        }
    }
    
    
    func getOnlineUser() {
        db.collection("users").whereField("status", isEqualTo: true).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for doc in querySnapshot!.documents {
                    let data = doc.data()
                    if let name = data["name"] as? String,
                        let photo = data["photo"] as? String,
                        let uid = data["uid"] as? String,
                        let status = data["status"] as? Bool{
                        self.users.append(User(userId: uid, photoURL: photo, name: name, status: status))
                    }
                }
                DispatchQueue.main.async {
                    self.onlineCollectionView.reloadData()
                }
            }
        }
    }
    
    func updateUserStatus(_ status : Bool){
        self.db.collection("users").whereField("uid", isEqualTo: userID!).getDocuments(){
            (querySnapshot, err) in
            if let err = err {
                print(err)
            } else if querySnapshot!.documents.count != 1 {
                print("duplicate")
            } else {
                let document = querySnapshot!.documents.first
                document?.reference.updateData([
                    "status": status
                ])
            }
        }
    }
}
//UI collection view

extension MainScreenController :   UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnlineUserCell", for: indexPath) as! OnlineUserCell
        
        let item = users[indexPath.row]
        cell.nameLbl.text = item.name
        cell.imgView.image = UIImage(named: "unnamed")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        desinationUserId = users[indexPath[1]]
        performSegue(withIdentifier: "gotoChat", sender: self)
    }
    
    
}

// UI table view

