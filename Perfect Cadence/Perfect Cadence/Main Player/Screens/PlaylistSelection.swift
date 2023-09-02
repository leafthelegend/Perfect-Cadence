//
//  PlaylistSelection.swift
//  Perfect Cadence
//
//  Created by Ella WANG on 26/8/2023.
//

import Foundation
import MediaPlayer
import SwiftUI


class PlaylistSelectionController: UIViewController, MPMediaPickerControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and configure the media picker controller
        let mediaPicker = MPMediaPickerController(mediaTypes: .music)
        mediaPicker.delegate = self
        mediaPicker.prompt = "Select a playlist to play"
        mediaPicker.allowsPickingMultipleItems = false
        
        present(mediaPicker, animated: true, completion: nil)
    }
    
    // selection cancelled
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // playlist selected
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        dismiss(animated: true, completion: nil)
    }
    
    func selectPlaylistButtonTapped() {
        let playlistSelectionVC = PlaylistSelectionController()
        present(playlistSelectionVC, animated: true, completion: nil)
    }
}



