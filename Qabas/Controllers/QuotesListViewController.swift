//
//  QuotesListViewController.swift
//  Qabas
//
//  Created by Razan bin rashed on 10/08/1443 AH.
//

import UIKit

class QuotesListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate {
 
   
    var QuoteList = [ QuoteInfo(BookName: "1Q84", AutherName: "Marie Curie", QuoteAddDate: "Added 10.02.22", QuoteDescription: "“Nothing in life is to be feared, it is only to be understood. Now is the time to understand more, so that we may fear less.”"),
    
                      QuoteInfo(BookName: "The Joke", AutherName: "Milan Kundera", QuoteAddDate: "Added 15.07.21", QuoteDescription: "“It is strange that only extraordinary men make the discoveries, which later appear so easy and simple.”"),
                      
                      QuoteInfo(BookName: "The Joke", AutherName: "Charles Darwin", QuoteAddDate: "Added 15.07.21", QuoteDescription: "“It is strange that only extraordinary men make the discoveries, which later appear so easy and simple.”"),
                      
                      QuoteInfo(BookName: "Identity", AutherName: "Georg C. Lichtenberg", QuoteAddDate: "Added 19.11.21", QuoteDescription: "“A man who dares to waste one hour of time has not discovered the value of life.”")
                      
    ]
    var searchMaterial:[QuoteInfo] = []
    var searching = false
    
    var GateName : String = ""
    var backfrom : Bool = true
    @IBOutlet weak var QuotesList: UITableView!
    
    @IBOutlet weak var SearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        QuotesList.delegate = self
        QuotesList.dataSource = self
        SearchBar.delegate = self
        
        registerCell()
//        self.navigationController?.isNavigationBarHidden = true
        if #available(iOS 13.0, *) {


            navigationItem.title = GateName
            let LeftMark = UIImage(systemName: "xmark.circle.fill")!
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: LeftMark,
                                style: .plain,
                                target: self,
                                action: #selector(QuotesListViewController.back(sender:)))
          

            navigationItem.leftBarButtonItem?.tintColor = .gray


            let RightMark = UIImage(systemName: "plus.circle.fill")!
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: RightMark,
                                style: .plain,
                                target: self,
                                                                action: #selector(QuotesListViewController.GoTo(sender:)))
         
                navigationItem.rightBarButtonItem?.tintColor = .gray
           
 
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func registerCell() {
        let cell = UINib(nibName: "QuoteTableViewCell",
                         bundle: nil)
        self.QuotesList.register(cell,
                                 forCellReuseIdentifier: "QuoteCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        QuoteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = QuotesList.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath ) as! QuoteTableViewCell
        cell.BookName.text = QuoteList[indexPath.row].BookName
        cell.AutherName.text = QuoteList[indexPath.row].AutherName
        cell.QuoteDate.text = QuoteList[indexPath.row].QuoteAddDate
        cell.TheQuoteDe.text = QuoteList[indexPath.row].QuoteDescription
        return cell
    }

    @objc func back(sender: UIBarButtonItem) {
          // Perform your custom actions
          // ...
          // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
        if backfrom {
          _ = navigationController?.popViewController(animated: true)
        }
        else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyList") as! MyListViewController

            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
      }
    @objc func GoTo(sender: UIBarButtonItem) {
          // Perform your custom actions
          // ...
   
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddQuotevc") as! AddQouteViewController
        
        
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("----1-----\(searchText)")
        searchMaterial = QuoteList
        print("----M-----\(searchMaterial)")
        if searchText.isEmpty == false{
            print("----1-----\(searchText)")
            searchMaterial = QuoteList.filter({ $0.QuoteDescription.lowercased().contains(searchText.lowercased())
             })
            print("----M-----\(searchMaterial)")
        }
        print("----1-----\(searchText)")
        print("----M-----\(searchMaterial)")
        SearchBar.setShowsCancelButton(true, animated: true)
       searching = true
        QuotesList.reloadData()

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        SearchBar.setShowsCancelButton(false, animated: true)
          searching = false
        SearchBar.text = ""
        QuotesList.reloadData()

      }
}

struct QuoteInfo {
    var BookName: String
    var AutherName: String
    var QuoteAddDate : String
    var QuoteDescription : String
    
}
