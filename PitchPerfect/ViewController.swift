//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Yugandhara Lad More on 2/14/17.
//  Copyright © 2017 Yugandhara Lad More. All rights reserved.
//

import UIKit

import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    
    @IBOutlet weak var lblRecordinginProgress: UILabel!
    
    @IBOutlet weak var btnRecording: UIButton!
    
    @IBOutlet weak var btnStopRecording: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        btnStopRecording.isEnabled = false
        
        
    }

  


    @IBAction func btnRecordAudio(_ sender: UIButton) {
        lblRecordinginProgress.text = "Recording in Progress"
        btnStopRecording.isEnabled = true
        btnRecording.isEnabled = false
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    
    @IBAction func btnStopRecording(_ sender: UIButton) {
        btnRecording.isEnabled = true
        btnStopRecording.isEnabled = false
        lblRecordinginProgress.text = "Tap to Record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag  {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
            
        } else {
            print("Recording was not successful")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "stopRecording" {
            
            print(segue)
            
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            
            let recordedAudioURL = sender as! URL
            
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
        
    }
    
}

