//
//  BPMViewModel.swift
//  Perfect Cadence
//
//  Created by Lief Lundmark-Aitcheson on 26/8/2023.
//

import Foundation
import Combine
import SpotifyWebAPI

class BPMViewModel : ObservableObject {
    func searchBPM(title: String, api: Spotify) -> Int? {
        let info = api.api.search(query: title, categories: [IDCategory.track])
        let subscriber = info.sink( receiveCompletion: { print ("completion: \($0)") },
                                    receiveValue: { print ("value: \($0)") })
        return title.count;
    }
}
