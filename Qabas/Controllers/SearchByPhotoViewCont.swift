//
//  SearchByPhotoViewCont.swift
//  Qabas
//
//  Created by Razan bin rashed on 10/08/1443 AH.
//

import Vision
import UIKit
import Foundation

class SearchByPhotoViewCont: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    let BookText = "Yes? she replied.Actually, I don;'t have any memories either. I'm dumb, you see, so could you tell me what memories are like? Miss Saeki stared at her hands on the desk, then looked up at Nakata again.Memories warm you up from the inside. But they also tear you apart. Nakata shook his head. That's a tough one. Nakata still doesn't understand.The only thing I understand is the present. I'm the exact opposite, Miss Saeki said. A deep silence settled over the room. Nakata was the one who broke it, lightly clearing his throat. Miss Saeki? Yes?"
    
    var imagechosed : UIImage?
    
    @IBOutlet var imageViwe: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBAction func SearchButton(_ sender: Any) {
        
        guard let UserInput = lable1.text else { return }
        
        if (BookText.contains(UserInput)){
            let controller = storyboard?.instantiateViewController(withIdentifier: "BookInfo") as! infobooknew
            
    //        controller.imagechosed = image
            
            navigationController?.pushViewController(controller, animated: true)
        }else{
            // home page
            let controller1 = storyboard?.instantiateViewController(withIdentifier: "Home") as! ViewController
            
            let alert = UIAlertController(title: "Sorry 😟", message: "the book not found", preferredStyle:.alert )
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {aciton in  self.navigationController?.pushViewController(controller1, animated: true)
                
                
            }))
            
            alert.addAction(UIAlertAction(title: "Try agine", style: .default, handler: {aciton in  self.navigationController?.pushViewController(controller1, animated: true)
                
                
            }))
            
            present(alert,animated: true, completion: nil)
        }
        
    }
    @IBOutlet weak var lable1: UILabel!
   
    
    // recognize method
    
    func recognizeText(image: UIImage?){
        guard let cgImage = image?.cgImage else {
            return
        }
      // handler
        let handler = VNImageRequestHandler(cgImage:  cgImage, options: [:])
        
    // Requset
        if #available(iOS 13.0, *) {
            let request = VNRecognizeTextRequest { [weak self] request,   error in
                    guard let observations = request.results as? [VNRecognizedTextObservation],
                           error == nil else {
                              return
                          }
                    let text = observations.compactMap({
                        $0.topCandidates(1).first?.string
                    }).joined(separator: " ")
                
                
                print("❤️",text)
                self?.setLabelText(text)
                }
                // process requset
                do{
                    try handler.perform([request])
                 
                }
                catch {
                    print(error)
                }
        } else {
            // Fallback on earlier versions
        }
       
        
    }
    
    
    // camera button
//    @IBAction func SeachByPhoto(_ sender: Any) {
//        print("Hello")
//        let vc = UIImagePickerController()
//        vc.sourceType = .photoLibrary
//        vc.delegate = self
//        vc.allowsEditing = true
//        present(vc, animated: true)
//
//    }
//    func ImageV (image2: UIImage){
//        imageViwe.image = image2
//    }
    
    func setLabelText(_ text:String){
        DispatchQueue.main.async {
            self.lable1.text = text
        }

    }
            
    @IBAction func SelectText(_ sender: Any) {
        recognizeText(image: imageViwe.image)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageViwe.image = imagechosed
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.navigationItem.title = "Qabas Lens"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(named: "Color") ?? .purple]
        
        if #available(iOS 13.0, *) {
            let LeftMark = UIImage(systemName: "xmark.circle.fill")!
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: LeftMark,
                                style: .plain,
                                target: self,
                                                               action: #selector(SearchByPhotoViewCont.back(sender:)))
            navigationItem.leftBarButtonItem?.tintColor = .gray
        } else {
            // Fallback on earlier versions
        }
    
    }
    @objc func back(sender: UIBarButtonItem) {
          // Perform your custom actions
          // ...
          // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
     
      }


}


