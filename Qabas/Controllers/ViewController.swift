//
//  ViewController.swift
//  Qabas
//
//  Created by Razan bin rashed on 20/07/1443 AH.
//


import UIKit
import Vision
import SwiftUI

class ViewController: UIViewController , UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    @AppStorage("isFristLaunch") var isFristLaunch : Bool = true
    
    let rightButton = UIButton(type: .system)
    enum CardState {
        case expanded
        case collapsed
    }
    
    //loc
//
//    override func viewDidAppear(_ animated: Bool) {
////        let Edit   = UIBarButtonItem(image: UIImage(systemName: "pencil")!,  style: .plain, target: self, action: nil)
////
////
////        let Gear = UIBarButtonItem(image: UIImage(systemName:  "gear")!, style: .plain, target: self, action: #selector(ProfileViewController.GoTo(sender:)))
////
////
////        navigationItem.rightBarButtonItems = [Edit, Gear]
//        navigationController?.navigationBar.tintColor = .red
//    }
    override func viewWillDisappear(_ animated: Bool) {
        rightButton.layer.opacity = 0
    }
    
    @IBOutlet weak var SearchMethod: UILabel!
    @IBOutlet weak var Tab: UILabel!
    @IBOutlet weak var Top5: UILabel!
    @IBOutlet weak var NavState: UINavigationItem!
    
    
    @IBOutlet weak var ProfileIcon: UIBarButtonItem!
    
    @IBOutlet weak var ViewButton: UIView!
    @IBOutlet weak var Fav: UIView!
    @IBOutlet weak var TextView: UIView!
    var cardViewController:CardViewController!
    var visualEffectView:UIVisualEffectView!
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var VoiceView: UIView!
    @IBOutlet weak var CameraView: UIView!
    let cardHeight:CGFloat = 844
    let cardHandleAreaHeight:CGFloat = 280
    
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    
    @IBOutlet weak var TabL: UILabel!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        // localization
        NavState.title = NSLocalizedString("Tilte", comment: "")
        Top5.text = NSLocalizedString("Top 5", comment: "")
        Tab.text = NSLocalizedString("Tap to Qabas", comment: "")
        SearchMethod.text = NSLocalizedString("Choose your favorite", comment: "")
        NavState.title = NSLocalizedString("Tilte", comment: "")
 
        
//      self.navigationController?.navigationBar.prefersLargeTitles = true
//
//        self.navigationItem.setHidesBackButton(true, animated: true)
//       self.navigationItem.title = "Discover"
//    self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
//
//
        
        
        TextView.alpha = 0
        CameraView.alpha = 0
        VoiceView.alpha = 0

        Fav.alpha = 0
        TabL.alpha = 1
        
        setupCard()
    
        
        ViewButton.isUserInteractionEnabled = true
        CameraView.isUserInteractionEnabled = true
        VoiceView.isUserInteractionEnabled = true
        TextView.isUserInteractionEnabled = true
        
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelClicked(_:)))
        ViewButton.addGestureRecognizer(guestureRecognizer)
                view.addSubview(ViewButton)
        
        let guestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(labelClickedCam(_:)))
        CameraView.addGestureRecognizer(guestureRecognizer2)
        view.addSubview(CameraView)
        
        
        
        let guestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(labelClickedVoice(_:)))
        VoiceView.addGestureRecognizer(guestureRecognizer3)
        view.addSubview(VoiceView)
        
        
        let guestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(labelClickedVoice(_:)))
        TextView.addGestureRecognizer(guestureRecognizer4)
        view.addSubview(TextView)
        
        

        
    }

    @objc func labelClickedText(_ sender: Any) {
        print("Hello")
    }
    @objc func labelClickedVoice(_ sender: Any) {
        print("Hello")
    }
    @objc func labelClickedCam(_ sender: Any) {
        print("Hello")
    }
    
    @objc func labelClicked(_ sender: Any) {
        print("hi")
    }
    //anmi
    func hiddenTabL(){
        
        UIView.animate(withDuration: 0.1, delay:0, animations: {() -> Void in
            self.TabL.alpha = 0
        })
        
        
    }
    func hiddenText(){
        
        UIView.animate(withDuration: 0.1, delay:0, animations: {() -> Void in
            self.TextView.alpha = 1
        })}
    
    
    func hiddenCam(){
        
        UIView.animate(withDuration: 0.7, delay:0, animations: {() -> Void in
            self.CameraView.alpha = 1
        })}
    
    func hiddenVoice(){
        
        UIView.animate(withDuration: 0.9, delay:0, animations: {() -> Void in
            self.VoiceView.alpha = 1
            
        })}
    func hiddenFav(){
        
        UIView.animate(withDuration: 0.9, delay:0, animations: {() -> Void in
            self.Fav.alpha = 1
            
        })
}
    
    @IBAction func CamB(_ sender: Any) {
       
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        print("hi")
        
    }
    
    
//    @IBAction func ProfilePage(_ sender: Any) {
//
//        let controller = storyboard?.instantiateViewController(withIdentifier: "ProfileID1") as! ProfileViewController
//
//        navigationController?.pushViewController(controller, animated: true)
//    }
//
    func setupNavBar() {
            
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.barStyle = .default
            rightButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
            rightButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
            navigationController?.navigationBar.addSubview(rightButton)
            rightButton.tag = 1
            rightButton.frame = CGRect(x: self.view.frame.width, y: 0, width: 120, height: 20)
            let targetView = self.navigationController?.navigationBar
            let trailingContraint = NSLayoutConstraint(item: rightButton, attribute:
                                                            .trailingMargin, relatedBy: .equal, toItem: targetView,
                                                       attribute: .trailingMargin, multiplier: 1.0, constant: -16)
            let bottomConstraint = NSLayoutConstraint(item: rightButton, attribute: .bottom, relatedBy: .equal,
                                                      toItem: targetView, attribute: .bottom, multiplier: 1.0, constant: -16)
            rightButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([trailingContraint, bottomConstraint])
        }
    
    @objc func profileTapped(){
        let controller = storyboard?.instantiateViewController(withIdentifier: "ProfileID1") as! ProfileViewController
    
            navigationController?.pushViewController(controller, animated: true)
        
    }
    @IBAction func Rec(_ sender: Any) {
      
        let controller = storyboard?.instantiateViewController(withIdentifier: "Rec") as! SpeechToTextViewController
        
//        controller.imagechosed = image
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func SearchText(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SearchText") as! SearchPage
        
//        controller.imagechosed = image
        
        navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
    @IBAction func ButtonTab(_ sender: Any) {
        hiddenText()
        hiddenTabL()
        hiddenCam()
        hiddenVoice()
        hiddenFav()
      
    }
    
    
    
    
    
    
    //    Card view setup
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        cardViewController = CardViewController(nibName:"CardViewController", bundle:nil)
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
          
        cardViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handleCardPan(recognizer:)))
        
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        
        
    }

    @objc
    func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
        
    }
    
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.cardViewController.view.layer.cornerRadius = 22
                    self.cardViewController.clicked.isHidden = false
                    self.cardViewController.navigationController?.isNavigationBarHidden = true
                    
                    self.ViewButton.isHidden = true
                    self.TextView.isHidden = true
                    self.VoiceView.isHidden = true
                    self.CameraView.isHidden = true
                case .collapsed:
                    self.cardViewController.view.layer.cornerRadius = 22
                    self.cardViewController.navigationController?.isNavigationBarHidden = false
                    self.navigationController?.navigationBar.prefersLargeTitles = true
                    self.navigationItem.setHidesBackButton(true, animated: true)
                    self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
                    self.ViewButton.isHidden = false
                    self.TextView.isHidden = false
                    self.VoiceView.isHidden = false
                    self.CameraView.isHidden = false
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
        }
    }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
     
        if isFristLaunch {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "OnBordingViewController")
            self.present(controller, animated: true, completion: nil)
            isFristLaunch = false
        }
        
        rightButton.layer.opacity = 1
        navigationController?.navigationBar.tintColor = UIColor(named: "Color") ?? .purple
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
          
          self.navigationItem.setHidesBackButton(true, animated: true)
         self.navigationItem.title = "Discover"
      self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
          
        self.navigationController?.navigationBar.backgroundColor = .white

          
        
    }
}


extension ViewController{

        internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
                
                // BMI Calculation Logic
              
                let controller = storyboard?.instantiateViewController(withIdentifier: "searchByImage") as! SearchByPhotoViewCont
                
                controller.imagechosed = image
                
                navigationController?.pushViewController(controller, animated: true)
//                SearchByPhotoViewCont.im(image)
             
            }

            picker.dismiss(animated: true, completion: nil)
            
        }
        func Opthions(){
            //SelectText()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }


        
        
        func setLabelText(_ text:String){
            DispatchQueue.main.async {
                self.lable1.text = text
            }
            
        }

    }


