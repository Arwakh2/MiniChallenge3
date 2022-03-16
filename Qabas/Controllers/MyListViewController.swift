//
//  MyListViewController.swift
//  Qabas
//
//  Created by Razan bin rashed on 10/08/1443 AH.
//

import UIKit

class MyListViewController: UIViewController {
//    @IBOutlet weak var FristView: UIView!
//    @IBOutlet weak var ScandView: UIView!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{

        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Books","Quotes"])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.navigationItem.title = "MyList"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(named: "Color") ?? .purple]
        
//        ---------------------------------------
        if #available(iOS 13.0, *) {

            let LeftMark = UIImage(systemName: "xmark.circle.fill")!
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: LeftMark,
                                style: .plain,
                                target: self,
                                action: #selector(MyListViewController.back(sender:)))
            navigationItem.leftBarButtonItem?.tintColor = .gray


            let RightMark = UIImage(systemName: "ellipsis.circle.fill")!
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: RightMark,
                                style: .plain,
                                target: nil,
                                action: nil)
            if #available(iOS 15.0, *) {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: RightMark, primaryAction: nil, menu: demoMenu)
                navigationItem.rightBarButtonItem?.tintColor = .gray
            } else {
                // Fallback on earlier versions
            }
            
          
//
//
//
//
        } else {
            // Fallback on earlier versions
        }

              

    }
    
    @available(iOS 13.0, *)
    var menuItems: [UIAction] {
     
        return [
            UIAction(title: "Add Categories", image: UIImage(systemName: "books.vertical"), handler: { (_) in
                self.AddCateItem()
            })
        ]
    }

    @available(iOS 15.0, *)
    var demoMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
    }

    func AddCateItem() {
        //Step : 1
               let alert = UIAlertController(title: "Your Category Name", message: "What’s your new Category Name?", preferredStyle: UIAlertController.Style.alert )
               //Step : 2
               let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
                   let textField = alert.textFields![0] as UITextField
                  
                   if textField.text != "" {
                       //Read TextFields text data
                       print(textField.text!)
                       print("newCate 1 : \(textField.text!)")
                       let categoryName = textField.text!

                       
                       let item =  CateList(CateName: categoryName, NumberOfQuote: 0)
                       Data.quoteList.append(item)
                       
                      // QuotesViewController().addItem(CateName: textField.text!)
               
                       
                   } else {
                       print("newCate 1 is Empty...")
                   }

               }

               //Step : 3
               //For first TF
               alert.addTextField { (textField) in
                   textField.placeholder = "Enter Category Name"
                   textField.textColor = .black
               }

               //Cancel action
               let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
               alert.addAction(cancel)
               //Step : 4
               alert.addAction(save)
               self.present(alert, animated:true, completion: nil)
 }
    
    @objc func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
      }
}


