//
//  VideoPlayerView.swift
//  VideoPlayer
//
//  Created by Aashish Adhikari on 4/21/19.
//  Copyright © 2019 Aashish Adhikari. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

protocol VideoPlayerViewDelegate{
    func didReachEndOfView()
}

class VideoPlayerView: UIView {
    
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var isLoop: Bool = false
    var currentTime: CMTime?
    
    var delegate: VideoPlayerViewDelegate?
    
    let playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pause"), for: .normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pause), for: .touchUpInside)
        return button
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let videoCurrentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.isUserInteractionEnabled = true
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(url: String, delegate: VideoPlayerViewDelegate? = nil) {
        self.delegate = delegate
        if let videoURL = URL(string: url) {
            #warning("Remove this line for API Integration")
            let videoURLFromStorage = URL(fileURLWithPath: url)
//            player = AVPlayer(url: videoURL)
            player = AVPlayer(url: videoURLFromStorage)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = bounds
            playerLayer?.videoGravity = AVLayerVideoGravity.resize
            if let playerLayer = self.playerLayer {
                layer.addSublayer(playerLayer)
            }
            
            self.addSubview(playPauseButton)
            playPauseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            playPauseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            playPauseButton.heightAnchor.constraint(equalToConstant: 50)
            playPauseButton.widthAnchor.constraint(equalToConstant: 50)
            
            self.addSubview(videoLengthLabel)
            videoLengthLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
            videoLengthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
            videoLengthLabel.widthAnchor.constraint(equalToConstant: 60)
            videoLengthLabel.heightAnchor.constraint(equalToConstant: 24)
            
            self.addSubview(videoCurrentTimeLabel)
            videoCurrentTimeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
            videoCurrentTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
            videoCurrentTimeLabel.widthAnchor.constraint(equalToConstant: 60)
            videoCurrentTimeLabel.heightAnchor.constraint(equalToConstant: 24)
            
            self.addSubview(videoSlider)
            videoSlider.leftAnchor.constraint(equalTo: videoCurrentTimeLabel.rightAnchor, constant: 8).isActive = true
            videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor, constant: -8).isActive = true
            videoSlider.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            videoSlider.heightAnchor.constraint(equalToConstant: 24)
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            player?.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 2), queue: .main, using: { progressTime in
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds) % 60)
                let minuteString = String(format: "%02d", Int(seconds) / 60)
                
                self.currentTime = progressTime
                
                self.videoCurrentTimeLabel.text = "\(minuteString):\(secondsString)"
                
                if let duration = self.player?.currentItem?.duration{
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.videoSlider.value = Float(seconds/durationSeconds)
                }
            })
            
            NotificationCenter.default.addObserver(self, selector: #selector(reachTheEndOfTheVideo(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges"{
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let secondText = Int(seconds) % 60
                let minuteText = Int(seconds) / 60
                videoLengthLabel.text = "\(minuteText):\(secondText)"
            }
            
        }
    }
    
    func play() {
        if player?.timeControlStatus != AVPlayer.TimeControlStatus.playing {
            player?.play()
        }
    }
    
    @objc func pause() {
        if player?.timeControlStatus != AVPlayer.TimeControlStatus.playing{
            player?.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }else{
            player?.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    @objc func handleSlider(){
        if let duration = player?.currentItem?.duration{
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime)
        }
    }
    
    func playVideoTo(current time: CMTime){
        player?.seek(to: time)
        player?.play()
    }
    
    func hideseekBar(){
        videoLengthLabel.isHidden = true
        videoCurrentTimeLabel.isHidden = true
        videoSlider.isHidden = true
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: CMTime.zero)
    }
    
    @objc func reachTheEndOfTheVideo(_ notification: Notification) {
        delegate?.didReachEndOfView()
    }
}


