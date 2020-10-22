//
//  ArticleViewController.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 29/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Class Properties
    private let resourseLoader = NetworkRequest() 
    private var articles = [Article]()
    private let cellSpacingHeight: CGFloat = 16
    private let imageCacheLoader = ImageCacheLoader()    
    enum ImageType {
        case article
        case avatar
    }

    //MARK: - UIViewController events
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        setAppearence()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getArticles()
    }

    //MARK:-  Private functions
    private func initTableView() {
        let nib = UINib.init(nibName: ArticleTableViewCell.identifier , bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: ArticleTableViewCell.identifier)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.allowsSelection = false
        tableView.isOpaque = false
        tableView.separatorStyle = .none
    }
    
    private func setAppearence() {
        self.view.backgroundColor = .lightGray
    }

    // MARK: - Networking
    private func getArticles() {
        let articlesResource = ArticlesResource()
        _ = resourseLoader.fetch(resource: articlesResource)  { [weak self] result in
           DispatchQueue.main.async {
                switch result {
                case .success(let successResult):
                    guard let articles = successResult.articles else { return }
                    self?.articles = articles
                    self?.tableView.reloadData()
                case .failure(let networkServerError):
                   print("networkServerError: \(networkServerError)")
               }
           }
        }
    }
}


//MARK: - UITableViewDelegate
extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int{
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let article = articles[indexPath.section]
        imageCacheLoader.cancelLoad(article.imageURL)
        imageCacheLoader.cancelLoad(article.author.authorAvatar.imageURL)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier ) as! ArticleTableViewCell
        
        let article = articles[indexPath.section]
        cell.delegate = self
        cell.tag = indexPath.section
        
        let articleImage: UIImage? = obtainImage(article.imageURL, .article, tableView, indexPath)
        let avatarImage: UIImage? = obtainImage(article.author.authorAvatar.imageURL, .avatar, tableView, indexPath)
                
        cell.viewModel = ArticleViewModel(fromArticle: article, articleImage: articleImage, avatarImage: avatarImage)
           
        return cell
    }
    
    fileprivate func obtainImage(_ articleImageUrl: String, _ imageType: ImageType, _ tableView: UITableView, _ indexPath: IndexPath) -> UIImage? {
        if let image = imageCacheLoader.getImageCache(imagePath: articleImageUrl) {
            return image
        } else {
            downloadImage(articleImageUrl, imageType, tableView, indexPath)
        }
        return nil
    }

    fileprivate func downloadImage(_ articleImageUrl: String, _ imageType: ImageType, _ tableView: UITableView, _ indexPath: IndexPath) {
         imageCacheLoader.obtainImageWithPath(imagePath: articleImageUrl) { [weak self] (image) in
             // Before assigning the image, check whether the current cell is visible
             if let updateCell = tableView.cellForRow(at: indexPath) as? ArticleTableViewCell {
                self?.setImage(updateCell, image, imageType)
             }
         }
    }
    
    fileprivate func setImage(_ updateCell: ArticleTableViewCell, _ image: UIImage, _ imageType: ImageType) {
          switch imageType {
          case .article:
              updateCell.articleImage = image
          case .avatar:
              updateCell.avatarImage = image
          }
      }
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemGroupedBackground
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return cellSpacingHeight
    }
}

//MARK: - ArticleFieldsDelegate
extension ArticlesViewController: ArticleFieldsDelegate {
    func likeField(isLiked: Bool, likesCount: Int, row: Int) {
        articles[row].isLiked = isLiked
        articles[row].likesCount = likesCount
    }
    
    func saveField(isSaved: Bool, row: Int) {
        articles[row].isSaved = isSaved
    }
}
