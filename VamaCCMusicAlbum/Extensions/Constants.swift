//
//  MusicAlbumCoordinator.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 8/3/24.
//

import UIKit

extension String {
    enum FileConstants {
        static let route = "route"
    }
    
    enum KeyConstants {
        static let PrimaryController = "primaryController"
        static let vmPairing = "vmPairing"
        static let viewPairing = "viewPairing"
        static let rssResults = "results"
        static let rssFeed = "feed"
        static let albumImage = "artworkUrl100"
        static let albumArtistName = "artistName"
        static let albumName = "name"
    }
    
    enum collectionHeaders {
        static let top100 = "Top 100 Albums"
    }
    
    enum URLConstants {
        static let rssFeed = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json"
    }
    
    enum errorDomainConstants {
        static let rssFeed = "com.rssfeed"
    }
    
    enum errorCodeMessage {
        static let rssFeedAbsence = "No RSS URL Found"
        static let rssFeedNoResults = "No RSS Results Found"
    }
}

extension Int {
    enum errorCodeConstants {
        static let rssFeedAbsence = 3000
        static let rssFeedNoResults = 3001
    }
}


