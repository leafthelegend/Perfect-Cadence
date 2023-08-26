//
//  QueueModel.swift
//  Perfect Cadence
//
//  Created by Ella WANG on 26/8/2023.
//

import Foundation
import os

// find the song w/ the closest BPM that's within +- 15%
func findClosestNumber(to pace: Double, in playlist: [Int:Int]) -> Optional<Int> {
    let logger = Logger()
    var theOne = 0
    if let BPM = playlist[theOne] {
        var minDifference = abs(pace - Double(BPM))
        
        for (id, BPM) in playlist {
            let difference = abs(pace - Double(BPM))
            if difference < minDifference {
                minDifference = difference
                theOne = id
            }
        }
        
        // the song we want is +- 0.15 around target
        if Int(0.85 * pace) < BPM && BPM < Int(1.15 * pace) {
            return theOne
        }
    }
    
    logger.info("empty playlist")
    return nil
}

func generateRandomNumbers(count: Int, min: Int, max: Int) -> [Int: Int] {
    var playlist: [Int: Int] = [:] //id: BPM
    for id in 0...count {
        playlist[id] = Int.random(in: min...max)
    }
    return playlist
}

func main() {
    let logger = Logger()
    logger.info("test")
    var lastFiveSelected = [Int]()
    let playlist = generateRandomNumbers(count: 100, min: 60, max: 240)
    
    for _ in 0...100 {
        let pace = Double(Int.random(in: 60...120))
        var possibleSongs: [Int:Int] = [:]
        
        for (id, BPM) in playlist {
            // not in the 5 songs recently played
            if !lastFiveSelected.contains(id) {
                possibleSongs[id] = BPM
            }
        }
        
        
        // closest BPM
        if let closestToPace = findClosestNumber(to: pace, in: possibleSongs) {
            logger.info("\(closestToPace)")
            lastFiveSelected.append(closestToPace)
        // Closest to pace/2 (2 steps per beat)
        } else if let closestToHalfPace = findClosestNumber(to: pace / 2, in: possibleSongs) {
            logger.info("\(closestToHalfPace)")
            lastFiveSelected.append(closestToHalfPace)
        // Closest to pace*2 (2 beats per step)
        } else if let closestToDoublePace = findClosestNumber(to: pace * 2, in: possibleSongs) {
            logger.info("\(closestToDoublePace)")
            lastFiveSelected.append(closestToDoublePace)
        } else {
            logger.info("No song in the playlist tha satisfies the criteria")
        }
        
        if lastFiveSelected.count > 5 {
            lastFiveSelected.remove(at: 0)
        }
    }
}

        
        
        
        
