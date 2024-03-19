//
//  RssFeeds.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 19/3/24.
//

import Foundation
import RealmSwift

class RSSFeeds: Object {
    @Persisted var feed: [RssFeed]
    
    
    convenience init(artistId : String, artistName : String = "", artistUrl : String = "") {
        self.init()
        self.artistId = artistId
        self.artistUrl = artistUrl
        self.artistName = artistName
    }
}

class RSSFeed: Object {
    @Persisted var feed: [RssFeed]
    @Persisted var artistId: String = ""
    @Persisted var artistName: String = ""
    
    convenience init(artistId : String, artistName : String = "", artistUrl : String = "") {
        self.init()
        self.artistId = artistId
        self.artistUrl = artistUrl
        self.artistName = artistName
    }
}



//struct RssFeeds: Codable {
//    var feed: [RssFeed]
//    
//}
//
//struct RssFeed: Codable {
//    var author: Author
//    var
//}
//
//struct Author: Codable {
//    var name: String
//    var url: String
//}
//
//struct Links: Codable {
//    var name: String
//    var url: String
//}
