//
//  MusicAlbumTileCollectionViewCell.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation
import UIKit

class MusicAlbumTileCollectionViewCell: UICollectionViewCell {
    let padding = 8.0
    var item:MusicAlbum?
    var image:UIImage?
    
    static var id: String {
        return "MusicAlbumTileCollectionViewCell"
    }
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "placeholder")
        view.layer.cornerRadius = 20.0
        view.clipsToBounds = true
        //        view.layer.cornerRadius = RM.shared.height(6)
        //        view.radius = RM.shared.height(6)
        return view
    }()
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        return lbl
    }()
    
    private lazy var artist: UILabel = {
        let artist = UILabel()
        artist.font = .systemFont(ofSize: 12, weight: .semibold)
        artist.translatesAutoresizingMaskIntoConstraints = false
        artist.textColor = UIColor(rgb: 0xB5B5B5)
        artist.numberOfLines = 1
        artist.lineBreakMode = .byTruncatingTail
        return artist
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
            flowCoordinator.handleAlert(title: String.viewStrings.errorInitializationForObjects)
        }
        fatalError(String.viewStrings.errorInitializationForObjects)
    }
    
    func setupViews() {
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.title)
        self.contentView.addSubview(self.artist)
    }
    
    func setupConstraints() {
        let imageViewConstraints = [
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
        
        let titleConstraints = [
            title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
            title.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
            artist.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            artist.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            artist.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant:-padding),
            artist.topAnchor.constraint(equalTo: title.bottomAnchor)
        ]
        NSLayoutConstraint.activate(titleConstraints)
    }
    
    func bindData(_ item: MusicAlbum) {
        self.item = item
        self.bindImage()
        self.bindLabels()
    }
    
    func bindLabels() {
        guard let i = item else {
            return
        }
        
        self.artist.text = i.artistName.capitalized
        self.title.text = i.name.capitalized
        
    }
    
    func bindImage() {
        guard let i = item, let iURL = URL(string: i.artworkUrl100) else {
            return
        }
        
        self.imageView.image = UIImage(named: "placeholder")
    
        self.imageView.downloadImage(from: iURL) { image in
            if let i = image {
                self.image = i
            }
        }
    }
    
    
}
