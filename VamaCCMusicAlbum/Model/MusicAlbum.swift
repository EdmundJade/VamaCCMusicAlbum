//
//  MusicAlbum.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 19/3/24.
//

import RealmSwift

class MusicAlbum: Object {
    
    @Persisted dynamic var url: String = ""
    @Persisted(primaryKey: true) dynamic var id: String = ""
    @Persisted dynamic var name: String = ""
    @Persisted dynamic var artworkUrl100: String = ""
    @Persisted dynamic var releaseDate:String = ""
    @Persisted dynamic var kind: String = ""
    @Persisted dynamic var contentAdvisoryRating: String = ""
    @Persisted dynamic var genres: List<Genre> = List<Genre>()
    @Persisted dynamic var artistUrl: String = ""
    @Persisted dynamic var artistId: String = ""
    @Persisted dynamic var artistName: String = ""
    
    convenience init(id:String, url:String = "", name:String = "", artworkUrl100:String = "", kind:String = "", contentAdvisoryRating:String = "", releaseDate:String = "", artistUrl:String = "", artistId:String = "", artistName:String = "") {
        self.init()
        self.id = id
        self.url = url
        self.name = name
        self.artworkUrl100 = artworkUrl100
        self.kind = kind
        self.contentAdvisoryRating = contentAdvisoryRating
        self.releaseDate = releaseDate
        self.artistId = artistId
        self.artistUrl = artistUrl
        self.artistName = artistName
    }
    
    
}



