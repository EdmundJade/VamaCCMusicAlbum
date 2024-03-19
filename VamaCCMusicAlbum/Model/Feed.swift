//
//  Feed.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 19/3/24.
//

import Foundation
import RealmSwift

class Feed: Object {
    
    @Persisted dynamic var author: Author?
    @Persisted dynamic var updated: String = ""
    @Persisted dynamic var country: String = ""
    @Persisted(primaryKey: true) dynamic var id: String = ""
    @Persisted dynamic var title: String = ""
    @Persisted dynamic var copyright: String = ""
    @Persisted dynamic var links: List<Link>
    @Persisted dynamic var icon: String = ""
    @Persisted dynamic var results: List<MusicAlbum> = List<MusicAlbum>()

    
    convenience init(id: String, country: String = "", title: String = "", icon: String = "", updated: String = "", copyright:String = "") {
        self.init()
        self.id = id
        self.country = country
        self.title = title
        self.icon = icon
        self.updated = updated
        self.copyright = copyright
    }
}

class Author: EmbeddedObject {
    @Persisted dynamic var name: String = ""
    @Persisted dynamic var url: String
}

class Link: EmbeddedObject {
    @Persisted dynamic var link: String = ""
}
