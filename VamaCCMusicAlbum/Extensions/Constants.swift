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
        static let rssFeed = "feed"
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
        static let rssFeedParserFailed = "Rss Feed Parsing Failed"
        static let rssFeedInstanceRetrievalFailed = "Unable to retrieve data from shared instance"
    }
    
    enum viewStrings {
        static let visitButton = "Visit The Album"
        static let released = "Released"
        static let ok = "Ok"
        static let errorTitle = "Top 100 Music Album Fetch Error Occured"
        static let errorMessage = "Do you want to retry?"
        static let yes = "Yes"
        static let no = "No"
        static let pullToRefresh = "Pull to refresh"
        static let refreshing = "Refreshing Main Page"
        static let errorInitialization = "Realm not initialized"
        static let errorDeletion = "Realm not deleting rows"
        static let errorDeletionAll = "Realm not deleting everything"
        static let errorInsertion = "Realm not inserting rows"
        static let errorDeletionForArray = "Realm not deleting arrays"
        static let errorInsertionForArray = "Realm not inserting arrays"
        static let errorUpdate = "Realm not updating rows"
        static let errorNotificationToken = "Notification Token Has some issue"
        static let errorInitializationForObjects = "init(coder:) has not been implemented"
        static let errorCoding = "This class does not support NSCoding"
    }
}

extension Int {
    enum errorCodeConstants {
        static let rssFeedAbsence = 3000
        static let rssFeedNoResults = 3001
        static let rssFeedParserFailed = 3002
        static let rssFeedInstanceRetrievalFailed = 3003
    }
}


