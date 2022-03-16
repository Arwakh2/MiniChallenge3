//
//  AddQouteViewController.swift
//  Qabas
//
//  Created by Razan bin rashed on 10/08/1443 AH.
//

import UIKit

class AddQouteViewController: UIViewController {
    
    @IBOutlet weak var ErorrMassege: UILabel!
    @IBOutlet weak var SaveQuote: UIButton!
    @IBOutlet weak var AuthorName: UITextField!
    @IBOutlet weak var BookName: UITextField!
    @IBOutlet weak var QuotesDes: UITextView!
    let placeholder = " Write The Quote here"
    var validation = Validation()
    override func viewDidLoad() {
        super.viewDidLoad()
        //styles
        SaveQuote.layer.cornerRadius = 8
        QuotesDes.layer.cornerRadius = 8
        //      UITextView
        QuotesDes.delegate = self
        QuotesDes.text = placeholder
        QuotesDes.textColor = UIColor.lightGray
        QuotesDes.selectedTextRange = QuotesDes.textRange(from: QuotesDes.beginningOfDocument, to: QuotesDes.beginningOfDocument)
        //   NavgationBar
        navigationItem.title = "Add Quote"
        if #available(iOS 13.0, *) {
            let LeftMark = UIImage(systemName: "xmark.circle.fill")!
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: LeftMark,
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(QuotesListViewController.back(sender:)))
            
            
            navigationItem.leftBarButtonItem?.tintColor = .gray
        } else {
            
        }
        
        
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func validateBtn(_ sender: Any) {
        
        guard let QuoteDesc = QuotesDes.text,
              let BookName = BookName.text,
              let Auther = AuthorName.text
        else {
            ErorrMassege.alpha = 1
            return  ErorrMassege.text = "Is Entered null value"
        }
        //              let isValidateQuoteDesc = self.validation.validateName(name: QuoteDesc)
        if (QuoteDesc.isEmpty) {
            print("Incorrect QuoteDesc")
            ErorrMassege.alpha = 1
            ErorrMassege.text = "Incorrect Quote"
            return
        }
        
        let isValidateBookName = self.validation.validateName(name: BookName)
        if (isValidateBookName == false) {
            print("Incorrect BookName")
            ErorrMassege.alpha = 1
            ErorrMassege.text = "Incorrect Book Name"
            return
        }
        let isValidateAuther = self.validation.validateName(name: Auther)
        if (isValidateAuther == false) {
            print("Incorrect Auther")
            ErorrMassege.alpha = 1
            ErorrMassege.text = "Incorrect Auther Name"
            return
        }
        //        isValidateQuoteDesc == true ||
        if ( isValidateBookName == true || isValidateAuther == true ) {
            print("All fields are correct")
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ListQoute") as! QuotesListViewController
            
            let date : Date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let todaysDate = dateFormatter.string(from: date)
            nextViewController.GateName = "Scenice"
            nextViewController.QuoteList.append(QuoteInfo(BookName: BookName, AutherName: Auther, QuoteAddDate: "Added \(todaysDate)", QuoteDescription: "“\(QuoteDesc)”"))
            
            nextViewController.backfrom = false
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
    }
}

extension AddQouteViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText: NSString = textView.text as NSString
        let updatedText = currentText.replacingCharacters(in: range, with:text)
        
        if updatedText.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            return false
        }
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
}

