//
//  UpcomingTableViewCell.swift
//  Netflix
//
//  Created by Ivan Potapenko on 23.07.2022.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {
    static let identifier = "UpcomingTableViewCell"

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let posterLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        clipsToBounds = true
        contentView.addSubview(posterImageView)
        contentView.addSubview(posterLabel)
        contentView.addSubview(playButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = CGRect(
            x: 5,
            y: 2,
            width: 100,
            height: height
        )
        posterLabel.frame = CGRect(
            x: posterImageView.right + 20,
            y: contentView.height/2 - posterLabel.height/2,
            width: contentView.width-posterImageView.right-15 - playButton.width - 10,
            height: contentView.height/2
        )
        
        playButton.frame = CGRect(
            x: posterLabel.right,
            y: contentView.height/2 - playButton.height/2,
            width: 40,
            height: 40
        )
    }
    
    public func configure(with model: UpcomingViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        posterImageView.sd_setImage(with: url, completed: nil)
        posterLabel.text = model.titleName
    }
}
