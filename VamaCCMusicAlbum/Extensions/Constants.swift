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
        static let flowBase = "flowBase"
        static let vmPairing = "vmPairing"
        static let viewPairing = "viewPairing"
        static let rssResults = "results"
        static let rssFeed = "feed"
        static let albumImage = "artworkUrl100"
        static let albumArtistName = "artistName"
        static let albumName = "name"
        static let albumURL = "url"
        static let releaseDate = "releaseDate"
        static let genres = "genres"
        static let genreURL = "url"
        static let genreName = "name"
    }
    
    enum collectionHeaders {
        static let top100 = "Top 100 Albums"
    }
    
    enum URLConstants {
        static let rssFeed = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/albums.json"
    }
    
    enum errorDomainConstants {
        static let rssFeed = "com.rssfeed"
    }
    
    enum errorCodeMessage {
        static let rssFeedAbsence = "No RSS URL Found"
        static let rssFeedNoResults = "No RSS Results Found"
    }
    
    enum viewStrings {
        static let visitButton = "Visit The Album"
        static let released = "Released"
        static let copyRight = "Copyright 2024 Apple Inc. All rights reserved."
    }
}

extension Int {
    enum errorCodeConstants {
        static let rssFeedAbsence = 3000
        static let rssFeedNoResults = 3001
    }
}


