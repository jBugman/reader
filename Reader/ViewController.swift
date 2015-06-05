//
//  ViewController.swift
//  Reader
//
//  Created by Sergey Parshukov on 21.06.14.
//  Copyright (c) 2014 bugman. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    @IBOutlet var textView : UITextView?
    @IBOutlet var button : UIButton?
    
    @IBAction func listenPressed() {
        switch true {
        case synthesizer.paused:
            synthesizer.continueSpeaking()
            button?.setTitle("Pause", forState: UIControlState.Normal)
        case synthesizer.speaking:
            synthesizer.pauseSpeakingAtBoundary(AVSpeechBoundary.Word)
            button?.setTitle("Continue", forState: UIControlState.Normal)
        default:
            let text = textView?.text
            speakChunk(text!)
            button?.setTitle("Pause", forState: UIControlState.Normal)
        }
//        let sentences = textView.text.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ",.!?"))
//        for sentence in sentences {
//            speakChunk(sentence)
//        }
        
    }
    
    let synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    func speakChunk(text: String) {
        var utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.3
//        utterance.pitchMultiplier = 0.3
        utterance.postUtteranceDelay = 0.03
        
        synthesizer.speakUtterance(utterance)
    }
    
    func clearHighlight() {
        let length = textView?.textStorage.length
        textView?.textStorage.removeAttribute(NSForegroundColorAttributeName, range: NSRange(location: 0, length: length!))
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        clearHighlight()
        textView?.textStorage.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: characterRange)
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didFinishSpeechUtterance utterance: AVSpeechUtterance) {
        clearHighlight()
        button?.setTitle("Listen", forState: UIControlState.Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        synthesizer.delegate = self
    }

}
