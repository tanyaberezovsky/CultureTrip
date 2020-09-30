//
//  ArticleViewController.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 29/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let resourseLoader = NetworkResourseLoader()
    private var articles = [Article]()
    private var imageCache = NSCache<AnyObject, AnyObject>()
    private var avatarCache = NSCache<AnyObject, AnyObject>()
    private let cellSpacingHeight: CGFloat = 16

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        setAppearence()
        getArticles()
    }
    
    deinit{
           print("deinit \(String(describing: self))")
    }
}

//MARK: Private functions
 extension ArticlesViewController {
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
    
    private func loadImage(_ imageURL: String?, _ imageView: UIImageView,_ imageCache: NSCache<AnyObject, AnyObject>) {
        guard let imageURL = imageURL else { return }
        if let image = imageCache.object(forKey: imageURL as AnyObject) as? UIImage {
            imageView.image = image
        } else {
            downloadImage(imageURL, RequestHandler(imageView, imageCache: imageCache))
        }
    }
}
//MARK:UITableViewDelegate
extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int{
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier ) as! ArticleTableViewCell
        let article = articles[indexPath.section]
        cell.categoryLabel.text = article.category
        cell.titleLabel.text = article.title
        cell.autorNameLabel.text = article.author?.authorName
        cell.updateTimeLabel.text = Date().getFormattedDate(dateString: article.metaData?.updateTime)
        cell.likeButton.isSelected = article.isLiked ?? false
        cell.saveButton.isSelected = article.isSaved ?? false
        cell.likesCount = article.likesCount ?? 0
        loadImage(article.imageURL, cell.articleImage, imageCache)
        loadImage(article.author?.authorAvatar?.imageURL, cell.avatarImage, avatarCache)
        return cell
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

// MARK: Networking
extension ArticlesViewController {
    private func getArticles() {
        let articlesResource = ArticlesResource()
        _ = resourseLoader.getArticles(resource: articlesResource)  { [weak self] results, errorMessage in
             
            if let results = results as? [Article] {
                self?.articles = results
                self?.tableView.reloadData()
             }
             
             if !errorMessage.isEmpty {
               print("Search error: " + errorMessage)
             }
           }
//           _ = networkHandler.fetch(resource: articlesResource) { networkResponse in
//               switch networkResponse {
//               case .success(let model, _):
//                   print(model)
//
//               case .failure(let networkServerError, let httpUrlResponce):
//                   //    Alert.showBasic(title: "", message: networkServerError.localizedDescription, vc: self)
//                   break
//               }
//           }
       }
}
