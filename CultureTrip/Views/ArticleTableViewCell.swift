//
//  ArticleTableViewCell.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 29/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import UIKit

protocol ArticleFieldsDelegate: class {
    func likeField(isLiked: Bool, likesCount: Int, row: Int)
    func saveField(isSaved: Bool, row: Int)
}

class ArticleTableViewCell: UITableViewCell {
    static let identifier: String = "ArticleTableViewCell"
    weak var delegate: ArticleFieldsDelegate?

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var autorNameLabel: UILabel!
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet private weak var likesCountLable: UILabel!
    var likesCount: Int = 0 {
        didSet {
            if likesCount > 0 {
                likesCountLable.text = "\(String(describing: likesCount))"
            } else {
                likesCountLable.text = ""
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setAppearence()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setAppearence() {
        likeButton.setImage(UIImage(assetIdentifier: .like), for: .normal)
        likeButton.setImage(UIImage(assetIdentifier: .liked), for: .selected)
        
        saveButton.setImage(UIImage(assetIdentifier: .save), for: .normal)
        saveButton.setImage(UIImage(assetIdentifier: .saved), for: .selected)
        
        backgroundColor = .white
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
        avatarImage.clipsToBounds = true
        
        titleLabel.font = .titleFont
        autorNameLabel.font = .subTextFont
        categoryLabel.font = .categoryFont
        
        titleLabel.textColor = .titleColor
        autorNameLabel.textColor = .subTextColor
        categoryLabel.textColor = .categoryColor
        likesCountLable.textColor = .activeElementTextColor
        updateTimeLabel.textColor = .secondarySubTextColor

    }
}

// MARK: Actions
extension ArticleTableViewCell {
    @IBAction private func likeTouch(_ sender: Any) {
        likeButton.isSelected = !likeButton.isSelected
        likesCount = likeButton.isSelected ? likesCount + 1 : likesCount - 1
        delegate?.likeField(isLiked: likeButton.isSelected, likesCount: likesCount, row: self.tag)
    }
    
    @IBAction private func saveTouch(_ sender: Any) {
        saveButton.isSelected = !saveButton.isSelected
        delegate?.saveField(isSaved: saveButton.isSelected, row: self.tag)
    }
}
