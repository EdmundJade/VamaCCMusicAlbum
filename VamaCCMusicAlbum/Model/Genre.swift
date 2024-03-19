//
//  Genre.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 19/3/24.
//

import Foundation
import RealmSwift

class Genre: EmbeddedObject {
    @Persisted dynamic var name: String = ""
    @Persisted dynamic var url: String = ""
    @Persisted dynamic var genreId: String
}
