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
    var item:[String: Any]?
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
    
    private lazy var musician: UILabel = {
        let musician = UILabel()
        musician.font = .systemFont(ofSize: 12, weight: .semibold)
        musician.translatesAutoresizingMaskIntoConstraints = false
        musician.textColor = UIColor(rgb: 0xB5B5B5)
        musician.numberOfLines = 1
        musician.lineBreakMode = .byTruncatingTail
        return musician
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.title)
        self.contentView.addSubview(self.musician)
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
            musician.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            musician.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            musician.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant:-padding),
            musician.topAnchor.constraint(equalTo: title.bottomAnchor)
        ]
        NSLayoutConstraint.activate(titleConstraints)
    }
    
    func bindData(_ item: [String: Any]) {
        self.item = item
        self.bindImage()
        self.bindLabels()
    }
    
    func bindLabels() {
        guard let i = item, let albumName = i[String.KeyConstants.albumName] as? String, let artistName = i[String.KeyConstants.albumArtistName] as? String else {
            return
        }
        
        self.musician.text = artistName.capitalized
        self.title.text = albumName.capitalized
        
    }
    
    func bindImage() {
        guard let i = item, let imageURL = i[String.KeyConstants.albumImage] as? String, let iURL = URL(string: imageURL) else {
            return
        }
        
        self.imageView.image = UIImage(named: "placeholder")
    
        if let imageCurrent = image {
            self.imageView.image = imageCurrent
        } else {
            downloadImage(from: iURL)
        }
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
                self?.imageView.image = self?.image
            }
        }
    }
    
}
