//
//  QueueModel.swift
//  Perfect Cadence
//
//  Created by Ella WANG on 26/8/2023.
//

import Foundation
import MediaPlayer

enum DEFAULTS{
    static let DEFAULT_BPM : Double = 100.0
}

class NextSongModel: ObservableObject{
    
    var bpmGetter: BPMGetter
    var lastFiveSelected = [String]()
    
    init(bpmGetter: BPMGetter) {
        self.bpmGetter = bpmGetter
//        let name : String? = nextSong()
//        print("next song: \(name)")
    }
    
    func pushSong(title: String){
        if lastFiveSelected.count >= 5{
            lastFiveSelected.removeFirst()
        }
        lastFiveSelected.append(title)
        print("lastFiveSelected: \(lastFiveSelected)")
    }
    
    // find the song w/ the closest BPM that's within +- 25%
    func findSongWithClosestBPM(to SPM: Double, in playlist: [String:Double?], bound: Bool = true) -> String? {
        var minDifference = 1000.0
        var theOne = ""
        for (query, bpm) in playlist{
            let BPM = bpm ?? DEFAULTS.DEFAULT_BPM
            let difference = abs(SPM - BPM)
            print("Difference for \(query) : \(difference)")
            if difference < minDifference {
                minDifference = difference
                theOne = query
            }
        }
        print(theOne)
        
        // empty prompt is BANNNNED
        if theOne.isEmpty {
            return nil
        }
        
        // don't adjust song more than 25%
        if let BPM = playlist[theOne] ?? DEFAULTS.DEFAULT_BPM {
            print("\(BPM),\(SPM), \(theOne)")
            if 0.75 * BPM < SPM && SPM < 1.25 * BPM {
                return theOne
            }
        }
        
        if !bound {
            return theOne
        }
        return nil
    }
    
    func fetchUserSongs(completion: @escaping ([String]?) -> Void) -> Void {
        let query = MPMediaQuery.songs()
        print("songs: \(query)")
    }

    
    func nextSong(songNames: [String], playlist: [String:Double?]) -> String? {
        let paceTracker = PaceTrackingModel()
        var songTitle : String? = ""
//        let SPM = Double(paceTracker.cadence) * 60.0
        let SPM = Double(120.0);
        var possibleSongs: [String:Double] = [:]
        
        for (query, BPM) in playlist {
            // not in the 5 songs recently played
            if !lastFiveSelected.contains(query) {
                possibleSongs[query] = BPM
            }
        }
        
        
        // closest BPM
        if let closestToSPM = self.findSongWithClosestBPM(to: SPM, in: possibleSongs) {
            songTitle = closestToSPM
            print("Branch 1")
        // Closest to pace*2 (2 beats per step)
        } else if let closestToDoubleSPM = self.findSongWithClosestBPM(to: SPM * 2, in: possibleSongs) {
            songTitle = closestToDoubleSPM
            print("Branch 2")
        // Closest to pace/2 (2 steps per beat)
        } else if let closestToHalfSPM = self.findSongWithClosestBPM(to: SPM / 2, in: possibleSongs) {
            songTitle = closestToHalfSPM
            print("Branch 3")
        } else {
            songTitle = self.findSongWithClosestBPM(to: SPM, in: playlist, bound: false)
            print("Branch 4")
        }
//            waiterGroup.leave(
//        let waiterGroup = DispatchGroup()
//        waiterGroup.enter()
//        self.bpmGetter.getBPMs(queries: songNames ?? [], categories: [.track]){playlist in
//
//        } // from getterBPM
//        waiterGroup.wait()
        return songTitle
    }
}

        
        
        
        
