//
//  String+UIViewController.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import UIKit

extension MusicAlbumViewController {
    public static func createWith(name:String) -> MusicAlbumViewController? {

        if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            if let viewControllerType = NSClassFromString("\(appName).\(name)") as? MusicAlbumViewController.Type {
                return viewControllerType.init()
            }
        }

        return nil
    }

}
