//
//  ArticleTableViewCell.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 29/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var autorNameLabel: UILabel!
    @IBOutlet private weak var updateTimeLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var likesCountLable: UILabel!
    
    //MARK: - Class Properties
    static let identifier: String = "ArticleTableViewCell"
    weak var delegate: ArticleFieldsDelegate?
    var likesCount: Int = 0 {
        didSet {
            if likesCount > 0 {
                likesCountLable.text = "\(String(describing: likesCount))"
            } else {
                likesCountLable.text = ""
            }
        }
    }
    
    //MARK: - Configuratte cell data
    var viewModel: ArticleViewModelProtocol? {
        didSet {
            guard let viewModel = self.viewModel else {
                return
            }
            self.categoryLabel.text = viewModel.category
            self.titleLabel.text = viewModel.title
            self.autorNameLabel.text = viewModel.authorName
            self.updateTimeLabel.text = viewModel.updateTime
            self.likeButton.isSelected = viewModel.isLiked
            self.saveButton.isSelected = viewModel.isSaved
            self.likesCount = viewModel.likesCount
            self.articleImage = viewModel.articleImage ?? UIImage()
            self.avatarImage = viewModel.articleImage ?? UIImage()
        }
    }
    
    var articleImage: UIImage = UIImage() {
        didSet {
            self.articleImageView.image = articleImage
        }
    }
    
    var avatarImage: UIImage = UIImage() {
           didSet {
               self.avatarImageView.image = avatarImage
           }
    }
       
    //MARK: - UITableViewCell events
    override func awakeFromNib() {
        super.awakeFromNib()
        setAppearence()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageView.image = nil
        avatarImageView.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: IBActions
    @IBAction private func likeTouch(_ sender: Any) {
        likeButton.isSelected = !likeButton.isSelected
        likesCount = likeButton.isSelected ? likesCount + 1 : likesCount - 1
        delegate?.likeField(isLiked: likeButton.isSelected, likesCount: likesCount, row: self.tag)
    }
    
    @IBAction private func saveTouch(_ sender: Any) {
        saveButton.isSelected = !saveButton.isSelected
        delegate?.saveField(isSaved: saveButton.isSelected, row: self.tag)
    }
    
    //MARK: - Private methods
    private func setAppearence() {
        likeButton.setImage(UIImage(assetIdentifier: .like), for: .normal)
        likeButton.setImage(UIImage(assetIdentifier: .liked), for: .selected)
        
        saveButton.setImage(UIImage(assetIdentifier: .save), for: .normal)
        saveButton.setImage(UIImage(assetIdentifier: .saved), for: .selected)
        
        backgroundColor = .white
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.clipsToBounds = true
        
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
