//
//  QuotesViewController.swift
//  Qabas
//
//  Created by Razan bin rashed on 10/08/1443 AH.
//

import UIKit


class QuotesViewController: UIViewController , UICollectionViewDelegate ,UICollectionViewDataSource{
  
 
    

    @IBOutlet weak var QouteCategries: UICollectionView!
    var quoteList = [
        CateList(CateName: "Scenice", NumberOfQuote: 19),
        CateList(CateName: "Design", NumberOfQuote: 17),
        CateList(CateName: "Psychological", NumberOfQuote: 9),
        CateList(CateName: "Historical Fiction ", NumberOfQuote: 13)
    ]{
        
        didSet{
            
            QouteCategries.reloadData()
//            quoteList.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        QouteCategries.dataSource = self
        QouteCategries.delegate = self
    }
 

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quoteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = QouteCategries.dequeueReusableCell(withReuseIdentifier: "QuoteCell", for: indexPath) as! QuoteCateogriesCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.CateogriesName.text = quoteList[indexPath.row].CateName
        cell.NumberofQuotesCate.text = "\(quoteList[indexPath.row].NumberOfQuote)"
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ListQoute") as! QuotesListViewController
        
        nextViewController.GateName = quoteList[indexPath.row].CateName
        
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }
  
    
    @available(iOS 13.0, *)
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let indexPathCate = indexPath.row
       
        let cellCateName = quoteList[indexPath.row].CateName
        
        @available(iOS 13.0, *)
        var menuItems: [UIAction] {
         
            return [
                UIAction(title: "Duplicate", image: UIImage(systemName: "doc.on.doc"), handler: {_ in
                    self.DuplicateItem(CateName: cellCateName, indexPath: indexPathCate)
             }),
                
                UIAction(title: "Rename", image: UIImage(systemName: "pencil"), handler: {(_) in
                    self.RenameItem(indexPath: indexPathCate)
                }),
                
                UIAction(title: "Delete", image: UIImage(systemName: "trash"),attributes: .destructive, handler: {(_) in
                    self.deleteItem(indexPath: indexPathCate)
//                    self.addItem(CateName: "hhhh")
                })
             
            ]
        }
        
        return UIContextMenuConfiguration(identifier: "QuoteCell" as NSCopying, previewProvider: nil, actionProvider: { _ in
            return UIMenu(title: "", children: menuItems)
        })

        
    }
    
    func deleteItem( indexPath: Int) {
   
        quoteList.remove(at: indexPath)
         let theIndex = IndexPath(row: indexPath, section: 0)
        QouteCategries.deleteItems(at: [theIndex])
    }

    
    func RenameItem( indexPath: Int) {
        //Step : 1
        let alert = UIAlertController(title: "Your Category Name", message: "What’s your new Category Name?", preferredStyle: UIAlertController.Style.alert )
        //Step : 2
        let save = UIAlertAction(title: "Save", style: .default) { [self] (alertAction) in
            let textField = alert.textFields![0] as UITextField
           
            if textField.text != "" {
                //Read TextFields text data
                print(textField.text!)
                print("TF 1 : \(textField.text!)")
                self.quoteList[indexPath].CateName = textField.text!
                 QouteCategries.reloadData()
                
            } else {
                print("TF 1 is Empty...")
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
    
    func addItem( CateName: String) {
            print("\\\\\\\\\\\\\\\\\\+\(CateName)")
            
            let item =  CateList(CateName: "Scenice", NumberOfQuote: 19)
            Data.quoteList.append(item)
            //quoteList.append(CateList(CateName: CateName, NumberOfQuote: 0))
           // let indexPath = IndexPath(row: quoteList.count - 1, section: 0)
            
            //QouteCategries.insertItems(at: [indexPath])
    //        guard let QouteCategries = QouteCategries else {print ("nill")
    //            return
    //        }
    //        QouteCategries.reloadData()
    //
        }
    
    func DuplicateItem(CateName: String , indexPath: Int) {
     
        let indexPath = IndexPath(row: indexPath, section: 0)
        QouteCategries.insertItems(at: [indexPath])
        quoteList.append(CateList(CateName: CateName, NumberOfQuote: 0))
        QouteCategries.reloadData()
    }
    

}

