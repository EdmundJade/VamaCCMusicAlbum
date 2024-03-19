//
//  AlbumDetailViewModel.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation
import UIKit

class AlbumDetailViewModel: MusicAlbumViewModel {
    
    var currentFeed: Feed? {
        get {
            let allFeeds = FeedInstance.shared.feeds
            if allFeeds.count > 0, let feed = allFeeds.first {
                return feed
            }
            return nil
        }
    }
    
    var currentAlbum: MusicAlbum? {
        get {
            if let p = params as? MusicAlbum {
                return p
            }
            return nil
        }
    }
    
    var genres:[Genre] {
        get {
            if let c = self.currentAlbum {
                return c.genres.toArray()
            }
            return []
        }
    }
    
    required init() {
        super.init()
    }
    
    func getCopyRightInfo() -> String {
        if let c = self.currentFeed {
            return c.copyright
        }
        return ""
    }
    
    
    
    func visitGenre(_ genre:Genre) {
        if let url = URL(string: genre.url) {
            UIApplication.shared.open(url)
        }
    }
    
    func visitAlbum() {
        guard let c = currentAlbum else {
            return
        }
        
        if let url = URL(string: c.url) {
            UIApplication.shared.open(url)
        }
    }
    
    func back() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
            flowCoordinator.back()
        }
    }
    
}
