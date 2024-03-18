//
//  MusicAlbumViewModel.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation

class MusicAlbumViewModel: NSObject {
    var params:Any? 
    
    public static func createWith(vcName:String) -> MusicAlbumViewModel? {
        guard let d = Dictionary<String, Any>.readFrom(String.FileConstants.route), let pairing = d[String.KeyConstants.vmPairing] as? [String: String] else {
            return nil
        }
        
        guard let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String, let pair = pairing[vcName], let viewModelClass = NSClassFromString("\(appName).\(pair)") as? MusicAlbumViewModel.Type else {
            return nil
        }

        return viewModelClass.init()
    }
    
    override required init() {
        super.init()
    }
}
