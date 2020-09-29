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
private extension ArticlesViewController {
    func initTableView() {
        let nib = UINib.init(nibName: ArticleTableViewCell.identifier , bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: ArticleTableViewCell.identifier)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.allowsSelection = false
        tableView.isOpaque = false
        tableView.separatorStyle = .none
    }
    
    func setAppearence() {
        self.view.backgroundColor = .lightGray
    }
}
//MARK:UITableViewDelegate
extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getEditFieldCell(cellForRowAt: indexPath)
    }

    func getEditFieldCell(cellForRowAt indexPath: IndexPath)->UITableViewCell{
        let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier ) as! ArticleTableViewCell
        let row = indexPath.row
        cell.autorNameLabel.text = self.articles[row].author?.authorName

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Networking
extension ArticlesViewController {
    private func getArticles() {
        let articlesResource = ArticlesResource()
        _ = resourseLoader.getArticles(resource: articlesResource)  { [weak self] results, errorMessage in
             
             if let results = results {
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
