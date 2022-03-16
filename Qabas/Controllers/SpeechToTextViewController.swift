//
//  SpeechToTextViewController.swift
//  Qabas
//
//  Created by Razan bin rashed on 10/08/1443 AH.
//

import UIKit
import Speech
import AVKit


class SpeechToTextViewController: UIViewController {
    enum CardState {
        case expanded
        case collapsed
    }
    
    let BookText = "Yes? she replied.Actually, I don;'t have any memories either. I'm dumb, you see, so could you tell me what memories are like? Miss Saeki stared at her hands on the desk, then looked up at Nakata again.Memories warm you up from the inside. But they also tear you apart. Nakata shook his head. That's a tough one. Nakata still doesn't understand.The only thing I understand is the present. I'm the exact opposite, Miss Saeki said. A deep silence settled over the room. Nakata was the one who broke it, lightly clearing his throat. Miss Saeki? Yes?"
    
    
    let cardHeight:CGFloat = 844
    let cardHandleAreaHeight:CGFloat = 280
    var cardViewController:CardViewController!
    var visualEffectView:UIVisualEffectView!
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    
    @IBOutlet weak var SearchBtn: UIButton!
    
    @IBOutlet weak var EnglishButton: UIButton!
    
    
    
    var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    
    

    var recognitionRequest      : SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask         : SFSpeechRecognitionTask?
    let audioEngine             = AVAudioEngine()
    var lang: String = "en-US"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "Discover"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.setupSpeech()
        
        btnStart.layer.cornerRadius = 8
        
//        EnglishButton.layer.cornerRadius = 8
        
        if audioEngine.isRunning {
            self.audioEngine.stop()
            self.recognitionRequest?.endAudio()
            self.btnStart.isEnabled = false
            self.btnStart.setTitle("  Start", for: .normal)
        } else {
            self.startRecording()
            self.btnStart.setTitle("  Stop", for: .normal)
        }
        
        //lblText.text.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        setupCard()
        
        
        if #available(iOS 13.0, *) {
            let LeftMark = UIImage(systemName: "xmark.circle.fill")!
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: LeftMark,
                                style: .plain,
                                target: self,
                                                               action: #selector(ProfileViewController.back(sender:)))
            navigationItem.leftBarButtonItem?.tintColor = .gray
            
        }
        else{
            
        }
    }
    
    @objc func back(sender: UIBarButtonItem) {
          // Perform your custom actions
          // ...
          // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
     
      }

    

    
    @IBAction func btnStartSpeechToText(_ sender: Any) {
        
//        if audioEngine.isRunning {
//            self.audioEngine.stop()
//            self.recognitionRequest?.endAudio()
//            self.btnStart.isEnabled = false
//            self.btnStart.setTitle("Start", for: .normal)
//        } else {
//            self.startRecording()
//            self.btnStart.setTitle("Stop", for: .normal)
//        }
  print("-------Search-------")
        guard let UserInput = lblText.text else { return }

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
    
    
    @IBAction func SearchBookInfo(_ sender: Any) {
        
        
      
            guard let UserInput = lblText.text else { return }

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
    func setupSpeech() {

        //self.btnStart.isEnabled = false
        
        
        self.btnStart.isEnabled = false
        
        self.speechRecognizer?.delegate = self

        SFSpeechRecognizer.requestAuthorization { (authStatus) in

            var isButtonEnabled = false

            switch authStatus {
            case .authorized:
                isButtonEnabled = true

            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")

            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")

            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            @unknown default:
                fatalError()
            }

            OperationQueue.main.addOperation() {
                self.btnStart.isEnabled = isButtonEnabled
            }
        }
    }

    //------------------------------------------------------------------------------

    func startRecording() {

        // Clear all previous session data and cancel task
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }

        // Create instance of audio session to record voice
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record, mode: AVAudioSession.Mode.measurement, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
            
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }

        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        let inputNode = audioEngine.inputNode

        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }

        recognitionRequest.shouldReportPartialResults = true

        self.recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in

            var isFinal = false

            if result != nil {

                self.lblText.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }

            if error != nil || isFinal {

                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.btnStart.isEnabled = true
            }
        })

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }

        self.audioEngine.prepare()

        do {
            try self.audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }

        self.lblText.text = "Speak Now!🎙♥️"
    }

    
    
    //    Card view setup
    func setupCard() {
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        visualEffectView.isUserInteractionEnabled = false
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
                
                case .collapsed:
                    self.cardViewController.view.layer.cornerRadius = 22
                    self.cardViewController.navigationController?.isNavigationBarHidden = false
                 
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

    

}

extension SpeechToTextViewController: SFSpeechRecognizerDelegate {

    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            self.btnStart.isEnabled = true
        } else {
            self.btnStart.isEnabled = false
        }
    }
}


