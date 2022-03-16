//
//  infobooknew.swift
//  Qabas
//
//  Created by Razan bin rashed on 10/08/1443 AH.
//

import UIKit

import AVFoundation
import Speech
import AVKit

class infobooknew: UIViewController , AVSpeechSynthesizerDelegate{

    @IBOutlet var JarirView: UIView!
    @IBOutlet var Pic1: UIImageView!
    
    @IBOutlet var REC: UIView!
    @IBOutlet var DeslABEL: UILabel!
    @IBOutlet var Des: UITextView!

    @IBOutlet var Pic3: UIImageView!
    @IBOutlet var Pic2: UIImageView!
    @IBOutlet var BookShopView: UIView!
    @IBOutlet var amazView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Book Info"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(named: "Color") ?? .purple]
      
        if #available(iOS 13.0, *) {
            let LeftMark = UIImage(systemName: "xmark.circle.fill")!
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: LeftMark,
                                style: .plain,
                                target: self,
                                                               action: #selector(self.back(sender:)))
            navigationItem.leftBarButtonItem?.tintColor = .gray
            
            let RightMarkShareImage = UIImage(systemName: "square.and.arrow.up.circle.fill")!
            let RightMarkShare   = UIBarButtonItem(image: RightMarkShareImage,  style: .plain, target: self, action: #selector(share(sender:)))
            let RightMarBookMarkImage = UIImage(systemName: "bookmark.circle.fill")!
            let RightMarBookMark = UIBarButtonItem(image: RightMarBookMarkImage,  style: .plain, target: self, action: nil)
            RightMarkShare.tintColor = UIColor.gray
            RightMarBookMark.tintColor = UIColor.gray
            navigationItem.rightBarButtonItems = [RightMarBookMark, RightMarkShare]
            
          
//            let RightMark = UIImage(systemName: "ellipsis.circle.fill")!
//            navigationItem.rightBarButtonItem = UIBarButtonItem(image: RightMark,
//                                style: .plain,
//                                target: nil,
//                                action: nil)
            
        
            
        } else {
            // Fallback on earlier versions
        }
        
       REC.layer.cornerRadius = 8
        JarirView.layer.cornerRadius = 8
        amazView.layer.cornerRadius = 8
        BookShopView.layer.cornerRadius = 8
        Pic1.layer.cornerRadius = 8
        Pic2.layer.cornerRadius = 8
        Pic3.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
    }
    @objc func share(sender:UIView){
            UIGraphicsBeginImageContext(view.frame.size)
            view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let textToShare = "Qabas"

            if let myWebsite = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX") {//Enter link to your app here
                let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

                //Excluded Activities
                activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                //

                activityVC.popoverPresentationController?.sourceView = sender
                self.present(activityVC, animated: true, completion: nil)
            }    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        Des.text=utterance.speechString
    }
    
    
    func readme(myText:String ,myLang : String )
    
    {
        let speechU = AVSpeechUtterance(string: myText)
        
        speechU.voice = AVSpeechSynthesisVoice(language: myLang)
                                               
       speechU.rate = 0.4
                                               
        let speechSynthesizer = AVSpeechSynthesizer()
        speechSynthesizer.speak(speechU)
    }
    
    @IBAction func Speaker(_ sender: Any) {
        let lang: String = "en-US"
        self.readme(myText: Des.text!, myLang: lang)
    }
  
    @objc func back(sender: UIBarButtonItem) {
          // Perform your custom actions
          // ...
          // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
     
      }
}


