//
//  ProfileViewController.swift
//  CardViewAnimation
//
//  Created by Ahad Obaid Albaqami on 09/08/1443 AH.
//  Copyright © 1443 Brian Advent. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var backgroundProfile: UIView!
    
    @IBOutlet weak var backgroundPlan: UIView!
    
    @IBOutlet weak var UpgradeBtn: UIButton!
    
    
   
    override func viewDidLoad() {
        
        backgroundProfile.layer.cornerRadius = 25
        
        backgroundPlan.layer.cornerRadius = 10
        UpgradeBtn.layer.cornerRadius = 10
        super.viewDidLoad()

        
  //self.navigationController?.isNavigationBarHidden = true
        
  //    self.navigationController?.isToolbarHidden = true
        
        
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//
//        self.navigationItem.title = "Profile"
//        // Do any additional setup after loading the view.
//
//      //  navigationController?.navigationBar.backgroundColor = UIColor(named: "BackgroundBar") ?? .blue
//
//
//        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(named: "Color") ?? .purple]
//
//
        if #available(iOS 13.0, *) {
            let LeftMark = UIImage(systemName: "xmark.circle.fill")!
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: LeftMark,
                                style: .plain,
                                target: self,
                                                               action: #selector(ProfileViewController.back(sender:)))
            self.navigationItem.leftBarButtonItem?.tintColor = .gray
       
            
            let Edit   = UIBarButtonItem(image: UIImage(systemName: "pencil")!,  style: .plain, target: self, action: nil)
            
            
            let Gear = UIBarButtonItem(image: UIImage(systemName:  "gear")!, style: .plain, target: self, action: #selector(ProfileViewController.GoTo(sender:)))
            
            
            navigationItem.rightBarButtonItems = [Edit, Gear]
            navigationController?.navigationBar.tintColor = .gray
            
        } else {
            // Fallback on earlier versions
        }
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.navigationItem.title = "Profile"
        // Do any additional setup after loading the view.
        
      //  navigationController?.navigationBar.backgroundColor = UIColor(named: "BackgroundBar") ?? .blue
            
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(named: "Color") ?? .purple]
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "BackgroundBar")

        
        //   self.navigationController?.navigationBar.tintColor = .blue
        //self.navigationController?.navigationBar.ba
      //  UINavigationBar.appearance().backgroundColor =  .purple
        
        //UINavigationBar.appearance().barTintColor = .black
//            let appearance = UINavigationBarAppearance()
//                appearance.backgroundColor = .purple
    }
    
    @objc func GoTo(sender: UIBarButtonItem) {
          // Perform your custom actions
          // ...
   
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SeetingID1") as! SeetingsViewController
        
        
        self.navigationController?.pushViewController(nextViewController, animated: true)

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
