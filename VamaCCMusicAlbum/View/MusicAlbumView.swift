//
//  Top100View.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation
import UIKit

class MusicAlbumView: UIView {
    
    var viewModel: MusicAlbumViewModel?
 
    public static func createWith(vcName:String) -> MusicAlbumView? {
        guard let d = Dictionary<String, Any>.readFrom(String.FileConstants.route), let pairing = d[String.KeyConstants.viewPairing] as? [String: String] else {
            return nil
        }
        
        guard let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String, let pair = pairing[vcName], let viewClass = NSClassFromString("\(appName).\(pair)") as? MusicAlbumView.Type else {
            return nil
        }

        return viewClass.init()
    }
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    convenience required init(_ viewModel:MusicAlbumViewModel) {
        self.init(frame: CGRect.zero)
        self.viewModel = viewModel
    }
    
    required init(coder aDecoder: NSCoder) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
            flowCoordinator.handleAlert(title: String.viewStrings.errorCoding)
        }
        fatalError(String.viewStrings.errorCoding)
    }
    
    func bindViewModel(_ viewModel:MusicAlbumViewModel) {
        self.viewModel = viewModel
    }
}
