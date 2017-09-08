//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Yugandhara Lad More on 2/15/17.
//  Copyright © 2017 Yugandhara Lad More. All rights reserved.
//

import UIKit

import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    
    @IBOutlet weak var chipmunkButton: UIButton!
    
    @IBOutlet weak var rabbitButton: UIButton!
    
    @IBOutlet weak var vaderButton: UIButton!
    
    @IBOutlet weak var echoButton: UIButton!
    
    @IBOutlet weak var reverbButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    
    var recordedAudioURL: URL!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
 
    @IBAction func playSoundForButtons(_ sender: UIButton) {
        print("Play sound button pressed")
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
        
    }
    
    
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        print("Stop audio button pressed")
        
    stopAudio()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    

}
