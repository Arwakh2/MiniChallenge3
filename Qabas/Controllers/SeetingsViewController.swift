//
//  SeetingsViewController.swift
//  CardViewAnimation
//
//  Created by Ahad Obaid Albaqami on 10/08/1443 AH.
//  Copyright © 1443 Brian Advent. All rights reserved.
//

import UIKit

class SeetingsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    // @IBOutlet weak var mybutton: UIButton!
     @IBOutlet weak var testtable: UITableView!
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      3
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell = testTableViewCell()
         
         
         if ( indexPath.row == 0){
              cell = tableView.dequeueReusableCell(withIdentifier: "languageCell1", for: indexPath) as! testTableViewCell
             cell.test1.text = ("Personal Information")
             
           
  
         }
         else  if ( indexPath.row == 1){
             cell = tableView.dequeueReusableCell(withIdentifier: "languageCell2", for: indexPath) as! testTableViewCell
             cell.test2.text = "Notifications"
              
        }
     
         else  {
             cell = tableView.dequeueReusableCell(withIdentifier: "languageCell3", for: indexPath) as! testTableViewCell
             cell.test3.text = ("Voice Over")
                
        }
         
 //        cell.test2.text = "test2"
 //        cell.test2.backgroundColor = .red
 //
 //        cell.test3.text = ("test3")
 //        cell.test3.backgroundColor = .red
         return cell
     }
     


     override func viewDidLoad() {
         testtable.dataSource = self
         testtable.delegate = self
         super.viewDidLoad()
         
         self.navigationController?.isNavigationBarHidden = false
         self.navigationController?.navigationBar.prefersLargeTitles = false
         
         self.navigationItem.title = "Settings"
         // Do any additional setup after loading the view.
         
         navigationController?.navigationBar.backgroundColor = .white
             
         
         self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(named: "Color") ?? .purple]
         
         
         if #available(iOS 13.0, *) {
             let LeftMark = UIImage(systemName: "xmark.circle.fill")!
             navigationItem.leftBarButtonItem = UIBarButtonItem(image: LeftMark,
                                 style: .plain,
                                 target: self,
                                                                action: #selector(SeetingsViewController.back(sender:)))
             navigationItem.leftBarButtonItem?.tintColor = .gray
        
         }
         else{
             
         }
         
//
//         let usersItem = UIAction(title: "Users", image: UIImage(systemName: "person.fill")) { (action) in
//
//               print("Users action was tapped")
//          }
//
//          let addUserItem = UIAction(title: "Add User", image: UIImage(systemName: "person.badge.plus")) { (action) in
//
//              print("Add User action was tapped")
//          }
//
//          let removeUserItem = UIAction(title: "Remove User", image: UIImage(systemName: "person.fill.xmark.rtl")) { (action) in
//               print("Remove User action was tapped")
//          }
//
//         _ = UIMenu(title: "My Menu", options: .displayInline, children: [usersItem , addUserItem , removeUserItem])
         
         
         // Do any additional setup after loading the view.
     }

    
    @objc func back(sender: UIBarButtonItem) {
          // Perform your custom actions
          // ...
          // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
     
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

