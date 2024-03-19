//
//  AlbumDetailView.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation
import UIKit

class AlbumDetailView: MusicAlbumView {
    
    let verticalStackPadding = 16.0
    let elementPadding = 12.0
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "placeholder")
        return view
    }()
    
    private lazy var verticalStack:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 0.0
        return stackView
    }()
    
    private lazy var horizontalStack:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8.0
        return stackView
    }()
    
    private lazy var artist: UILabel = {
        let lbl = UILabel()
        lbl.text = "13wetgdg"
        lbl.font = .systemFont(ofSize: 18, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(rgb:0x8E8E93)
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        return lbl
    }()
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.text = "dshgkdnshkdhg"
        lbl.font = .systemFont(ofSize: 34, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(rgb:0x111226)
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        return lbl
    }()
    
    private lazy var releaseDate: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(rgb: 0xB5B5B5)
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(tapBack(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        button.layer.cornerRadius = 16.0
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btnBack"), for: .normal)
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 6.5, leading: 10, bottom: 6.5, trailing: 10)
            button.configuration = configuration
        } else {
            button.contentEdgeInsets = UIEdgeInsets(top: 6.5, left: 10, bottom: 6.5, right: 10)
        }
        
        return button
    }()
    
    private lazy var visitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(visitAlbum(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor(rgb: 0x007AFF)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.filled()
            configuration.title = String.viewStrings.visitButton
            configuration.contentInsets = NSDirectionalEdgeInsets(top: elementPadding, leading: verticalStackPadding, bottom: elementPadding, trailing: verticalStackPadding)
            button.setAttributedTitle(NSAttributedString(string:String.viewStrings.visitButton, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .semibold)]), for: .normal)
            button.configuration = configuration
        } else {
            button.contentEdgeInsets = UIEdgeInsets(top: elementPadding, left: verticalStackPadding, bottom: elementPadding, right: verticalStackPadding)
            if let lbl = button.titleLabel {
                lbl.font = .systemFont(ofSize: 16, weight: .semibold)
                lbl.textColor = .white
                lbl.numberOfLines = 1
            }
            button.setTitle(String.viewStrings.visitButton, for: .normal)
        }
        
        return button
    }()
    
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setupViews()
        self.setUpConstraints()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
            flowCoordinator.handleAlert(title: String.viewStrings.errorCoding)
        }
        fatalError(String.viewStrings.errorCoding)
    }
    
    func setupViews() {
        self.addSubview(imageView)
        self.addSubview(backButton)
        self.addSubview(verticalStack)
        verticalStack.addArrangedSubview(artist)
        verticalStack.addArrangedSubview(title)
        verticalStack.setCustomSpacing(elementPadding, after: title)
        verticalStack.addArrangedSubview(horizontalStack)
        self.addSubview(releaseDate)
        self.addSubview(visitButton)
    }
    
    func setUpConstraints() {
        let imageConstraints = [
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ]
        NSLayoutConstraint.activate(imageConstraints)
        
        let backConstraints = [
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: verticalStackPadding),
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: verticalStackPadding),
            backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 32)
        ]
        NSLayoutConstraint.activate(backConstraints)
        
        let verticalStackConstraints = [
            verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:verticalStackPadding),
            verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -verticalStackPadding),
            verticalStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: elementPadding)
        ]
        NSLayoutConstraint.activate(verticalStackConstraints)
        
        let buttonConstraints = [
            visitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            visitButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -elementPadding)
        ]
        NSLayoutConstraint.activate(buttonConstraints)
        
        let releaseDateConstraints = [
            releaseDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:verticalStackPadding),
            releaseDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -verticalStackPadding),
            releaseDate.bottomAnchor.constraint(equalTo: visitButton.topAnchor, constant: -elementPadding*2)

        ]
        NSLayoutConstraint.activate(releaseDateConstraints)
        
    }
    
    func bindImage() {
        guard let vm = self.viewModel as? AlbumDetailViewModel, let i = vm.currentAlbum, let iURL = URL(string: i.artworkUrl100) else {
            return
        }
        
        self.imageView.downloadImage(from: iURL)
    }
    
    func bindText() {
        guard let vm = self.viewModel as? AlbumDetailViewModel, let i = vm.currentAlbum else {
            return
        }
        
        self.title.text = i.name.capitalized
        self.artist.text = i.artistName.capitalized
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from:i.releaseDate) {
            dateFormatter.dateFormat = "dd MMM, yyyy"
            self.releaseDate.text = "\(String.viewStrings.released) \(dateFormatter.string(from: date))\n\(vm.getCopyRightInfo())"
        }
        
        if vm.genres.count > 0 {
            if self.horizontalStack.arrangedSubviews.count > 0 {
                for view in self.horizontalStack.arrangedSubviews {
                    self.horizontalStack.removeArrangedSubview(view)
                }
            }
            
            for genre in vm.genres {
                self.addGenre(genre)
            }
            
        }
    }
    
    func addGenre(_ genre:Genre) {
        let button = GenreButton(genre: genre)
        button.addTarget(self, action: #selector(visitGenre(_:)), for: .touchUpInside)
        button.setAttributedTitle(NSAttributedString(string:genre.name, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: .medium)]), for: .normal)
        
        self.horizontalStack.addArrangedSubview(button)
    }
    
    override func bindViewModel(_ viewModel:MusicAlbumViewModel) {
        super.bindViewModel(viewModel)
        self.bindImage()
        self.bindText()
    }
    
    @objc func tapBack(_ sender: UIButton) {
        guard let vm = self.viewModel as? AlbumDetailViewModel else {
            return
        }
        
        vm.back()
    }
    
    @objc func visitGenre(_ sender: GenreButton) {
        guard let vm = self.viewModel as? AlbumDetailViewModel else {
            return
        }
        
        if let genre = sender.genre {
            vm.visitGenre(genre)
        }
    }
    
    @objc func visitAlbum(_ sender: UIButton) {
        guard let vm = self.viewModel as? AlbumDetailViewModel else {
            return
        }
        
        vm.visitAlbum()
    }
}
