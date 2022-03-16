//
//  CardViewController.swift
//  Qabas
//
//  Created by Razan bin rashed on 05/08/1443 AH.
//

import UIKit

class CardViewController: UIViewController {
    
    
    
    @IBOutlet weak var lastDiscover: UILabel!
    
    @IBOutlet weak var Book1: UILabel!
    @IBOutlet weak var Author1: UILabel!
    @IBOutlet weak var Book2: UILabel!
    @IBOutlet weak var Author2: UILabel!
    @IBOutlet weak var Book3: UILabel!
    @IBOutlet weak var Author3: UILabel!
    @IBOutlet weak var Book4: UILabel!
    @IBOutlet weak var Author4: UILabel!
    @IBOutlet weak var Book5: UILabel!
    @IBOutlet weak var Author5: UILabel!
    
    
    
    
    @IBOutlet weak var MyList: UILabel!
    
    @IBOutlet weak var SeeAll: UIButton!
    @IBOutlet weak var Book6: UILabel!
    
    
    @IBOutlet weak var Author6: UILabel!
    
    @IBOutlet weak var Book7: UILabel!
    
    @IBOutlet weak var Author7: UILabel!
    
    @IBOutlet weak var Book8: UILabel!
    
    @IBOutlet weak var Author8: UILabel!
    
    @IBOutlet weak var Book9: UILabel!
    
    @IBOutlet weak var Author9: UILabel!
    
    @IBOutlet weak var Book10: UILabel!
    
    @IBOutlet weak var Picks: UILabel!
    @IBOutlet weak var Author10: UILabel!
    
    @IBOutlet weak var SeeAll2: UILabel!
    
    @IBOutlet weak var Book11: UILabel!
    
    @IBOutlet weak var Author11: UILabel!
    
    @IBOutlet weak var Book12: UILabel!
    @IBOutlet weak var Author12: UILabel!
    
    @IBOutlet weak var Book13: UILabel!
    
    @IBOutlet weak var Book14: UILabel!
    @IBOutlet weak var Author13: UILabel!
    
    @IBOutlet weak var Author14: UILabel!
    @IBOutlet weak var Book15: UILabel!
    @IBOutlet weak var Author15: UILabel!
    @IBOutlet weak var SeeAllMyList: UIButton!
    
    
    @IBOutlet weak var clicked: UIView!
    @IBOutlet weak var handleArea: UIView!
    
   
    
    @IBAction func SeeAllButton(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyList") as! MyListViewController
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // localization
        // first row
        lastDiscover.text = NSLocalizedString("History", comment: "")
            Book1.text = NSLocalizedString("book1", comment: "")
            Author1.text = NSLocalizedString("Author1", comment: "")
            Book2.text = NSLocalizedString("book2", comment: "")
            Author2.text = NSLocalizedString("Author2", comment: "")
            Book3.text = NSLocalizedString("book3", comment: "")
            Author3.text = NSLocalizedString("Author3", comment: "")
            Book4.text = NSLocalizedString("book4", comment: "")
            Author4.text = NSLocalizedString("Author4", comment: "")
            Book5.text = NSLocalizedString("book5", comment: "")
            Author5.text = NSLocalizedString("Author5", comment: "")
            
            // second row
            MyList.text = NSLocalizedString("List", comment: "")
            SeeAll.titleLabel?.text = NSLocalizedString("See all", comment: "")
            Book6.text = NSLocalizedString("book6", comment: "")
            Author6.text = NSLocalizedString("Author6", comment: "")
            Book7.text = NSLocalizedString("book7", comment: "")
            Author7.text = NSLocalizedString("Author7", comment: "")
            Book8.text = NSLocalizedString("Book 8", comment: "")
            Author8.text = NSLocalizedString("Author8", comment: "")
            Book9.text = NSLocalizedString("book9", comment: "")
            Author9.text = NSLocalizedString("Author9", comment: "")
            Book10.text = NSLocalizedString("book10", comment: "")
            Author10.text = NSLocalizedString("Author10", comment: "")
           
            // 3ed row
            Picks.text = NSLocalizedString("Pick", comment: "")
            SeeAll2.text = NSLocalizedString("See all", comment: "")
            Book11.text = NSLocalizedString("Book11", comment: "")
            Author11.text = NSLocalizedString("Author11", comment: "")
            Book12.text = NSLocalizedString("Book12", comment: "")
            Author12.text = NSLocalizedString("Author12", comment: "")
            Book13.text = NSLocalizedString("book13", comment: "")
            Author13.text = NSLocalizedString("author13", comment: "")
            Book14.text = NSLocalizedString("book14", comment: "")
            Author14.text = NSLocalizedString("Author14", comment: "")
            Book15.text = NSLocalizedString("book15", comment: "")
            Author15.text = NSLocalizedString("author15", comment: "")
            
            
        
    }
}
