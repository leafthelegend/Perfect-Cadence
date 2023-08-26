//
//  BPMGetter.swift
//  Perfect Cadence
//
//  Created by Lief Lundmark-Aitcheson on 26/8/2023.
//

import Foundation
import Combine
import SpotifyWebAPI

class BPMGetter: ObservableObject {
    private let spotify: Spotify = Spotify()
        
    //    var tracks: [Track] = []
        
    private var alert: AlertItem? = nil
        
    private var searchCancellables: [AnyCancellable?] = []
    private var infoCancellables: [AnyCancellable?] = []
    func search(query: String, categories: [IDCategory], handler: @escaping (Double?) -> Void) {
        var tracks : [Track] = []
        if query.isEmpty {handler(nil); return }

        self.searchCancellables.append( spotify.api.search(
            query: query, categories: categories
        )
        .receive(on: RunLoop.main)
        .sink(
            receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.alert = AlertItem(
                        title: "Couldn't Perform Search",
                        message: error.localizedDescription
                    )
                    print("error: \(error)")
                }
            },
            receiveValue: { searchResults in
                tracks = searchResults.tracks?.items ?? []
                let uri = tracks[0].uri ?? "";
                print("URI: \(uri)")
                self.getCurrentBPM(URI: uri, handler: handler)
            }
        ))
    }
    func getCurrentBPM(URI: SpotifyURIConvertible, handler: @escaping (Double?) -> Void){
        self.infoCancellables.append(
            spotify.api.trackAudioFeatures(URI)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        handler(nil)
                        self.alert = AlertItem(
                            title: "Couldn't Perform Feature Request",
                            message: error.localizedDescription
                        )
                        print("error: \(error)")
                    }
                },
                receiveValue: { features in
                    handler(features.tempo)
                }
            )
        )
    }
    func getBPMs(queries: [String], categories: [IDCategory], completion: @escaping ([String:Double?])->Void){
        var result = [String:Double?]()
        let group = DispatchGroup()
        for query in queries {
            group.enter()
            search(query: query,categories: categories){bpm in
                result[query] = bpm
                group.leave()
            }
        }
        group.notify(queue: .main){
            completion(result)
        }
    }
    func getBPM(title:String, handler: @escaping (Double?)->Void){
        search(query: title, categories: [.track]){bpm in
            handler(bpm)
        }
    }
}
