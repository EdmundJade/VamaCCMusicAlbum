//
//  Object+Parser.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 19/3/24.
//

import Foundation
import RealmSwift

extension Results {
    func toArray<T>() -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}

extension List {
    func toArray<T>() -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
