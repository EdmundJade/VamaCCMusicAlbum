//
//  genreButton.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 19/3/24.
//

import Foundation
import UIKit

class GenreButton:UIButton {
    var genre:[String:String]?
    
    convenience init(genre:[String:String]) {
        self.init(type: .custom)
        self.genre = genre
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        self.layer.borderColor = UIColor(rgb: 0x007AFF).cgColor
        self.layer.borderWidth = 1.0
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.bordered()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
            configuration.baseBackgroundColor = .clear
            self.configuration = configuration
        } else {
            if let lbl = self.titleLabel {
                lbl.font = .systemFont(ofSize: 10, weight: .medium)
                lbl.textColor = UIColor(rgb: 0x007AFF)
                lbl.numberOfLines = 1
            }
            self.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        }
    }
}
