//
//  EventTableViewCell.swift
//  iTechArtApp
//
//  Created by Tsimafei Zykau on 11/24/20.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    let authorLabel = UILabel()
    let avatarView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

}

extension EventTableViewCell {
    // MARK: Configure cell
    func configureCell() {
        self.backgroundColor = .white
        configureAuthorLabel()
        configureAvatarView()
        configureDateLabel()
        configureConstraints()
    }
    
    // MARK: Configure authorLabel
    func configureAuthorLabel() {
        self.addSubview(authorLabel)
        authorLabel.textColor = .black
        authorLabel.font = UIFont.systemFont(ofSize: 24)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Configure avatarView
    func configureAvatarView() {
        self.addSubview(avatarView)
        avatarView.contentMode = .scaleAspectFit
        avatarView.layer.masksToBounds = false
        avatarView.layer.cornerRadius = avatarView.frame.size.width / 2
        avatarView.clipsToBounds = true
        avatarView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Configure dateLabel
    func configureDateLabel() {
        self.addSubview(dateLabel)
        dateLabel.textColor = .black
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Configure constraints
    func configureConstraints() {
        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            avatarView.widthAnchor.constraint(equalToConstant: 50),
            avatarView.heightAnchor.constraint(equalToConstant: 50),
            avatarView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            authorLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 5),
            authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            authorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            authorLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 25),
            
            dateLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
    }
}
