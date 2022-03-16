//
//  BookListViewController.swift
//  Qabas
//
//  Created by Razan bin rashed on 10/08/1443 AH.
//

import UIKit

class BookListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
  
    var BookList = [
        BookInfo(BookImage: "BookImage", BookName: "1Q84", BookAuther: "Murakami", BookDescription: "This is the real world, there is no doubt about that.But in this world, there are two moons in the sky.", BookRate: 4.6, IsBookMared: true),
        BookInfo(BookImage: "BookImage2", BookName: "The Joke", BookAuther: "Milan Kundera", BookDescription: "The Joke, Milan Kundera's first novel, gained him a huge following in his own country and launched his worldwide literary reputation.", BookRate: 4.5, IsBookMared: true),
        BookInfo(BookImage: "BookImage3", BookName: "Identity", BookAuther: "Milan Kundeera", BookDescription: "Sometimes--perhaps only for an instant--we fail to recognize a companion", BookRate: 3.6, IsBookMared: true),
        BookInfo(BookImage: "BookImage4", BookName: "The Undearable Lightness Of Being", BookAuther: "Milan Kundeera", BookDescription: "Sometimes--perhaps only for an instant--we fail to recognize a companion", BookRate: 4.5, IsBookMared: true),

    ]
    
    @IBOutlet weak var BookListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        BookListTable.delegate = self
        BookListTable.dataSource = self
        registerCell()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func registerCell() {
        let cell = UINib(nibName: "BookTableViewCell",
                            bundle: nil)
        self.BookListTable.register(cell,
                                forCellReuseIdentifier: "BookCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return BookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath ) as! BookTableViewCell
        
        
        if BookList[indexPath.row].IsBookMared {
        cell.BookImage.image = UIImage(named: BookList[indexPath.row].BookImage)
        cell.BookName.text = BookList[indexPath.row].BookName
        cell.AutherName.text = BookList[indexPath.row].BookAuther
        cell.BookDescription.text = BookList[indexPath.row].BookDescription
        cell.rateBook.text = "\(BookList[indexPath.row].BookRate)"
        }
    

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! BookTableViewCell
        
        if #available(iOS 13.0, *) {
            cell.IsBookMarked.image = UIImage(systemName: "bookmark")
            BookList[indexPath.row].IsBookMared = false
        }

    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! BookTableViewCell
        print("///////\(  BookList[indexPath.row].IsBookMared)")
        if #available(iOS 13.0, *) {
            cell.IsBookMarked.image = UIImage(systemName: "bookmark.fill")
            BookList[indexPath.row].IsBookMared = true
        } else {
            // Fallback on earlier versions
        }

    }
    
}

struct BookInfo {
    var BookImage:String
    var BookName: String
    var BookAuther: String
    var BookDescription:String
    var BookRate:Double
    var IsBookMared :Bool
    
}

