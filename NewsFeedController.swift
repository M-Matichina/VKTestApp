//
//  NewsFeedController.swift
//  VKTestApp
//
//  Created by Мария Матичина on 5/17/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var fetcher: DataFetcher = NetworkingNewsFeedFetcher(networking: NetworkService())
    
    var news: [NewsFeedItem] = []
    var selectedNews: NewsFeedItem?
    var isLoading = false
    var startFrom: String? // при первом запросе он пустой (работает для 2+ отправок)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureLoader()
        configureNavBar()
    }
    
    func configureLoader() {
        activityIndicator.isHidden = true
        activityIndicator.layer.cornerRadius = 10.0
        activityIndicator.layer.masksToBounds = true
    }
    
    func fetchNewsFeed(_ startFrom: String?) {
        isLoading = true
        
        if news.isEmpty {
            showLoader()
        }
        
        fetcher.getNewsFeed(startFrom: startFrom) { [weak self] (newsFeedResponse) in
            guard let strongSelf = self, let newsFeedResponse = newsFeedResponse else { return }
            
            strongSelf.hideLoader()
            strongSelf.startFrom = newsFeedResponse.nextFrom
            strongSelf.isLoading = false
            strongSelf.news.append(contentsOf: newsFeedResponse.items)
            strongSelf.tableView.reloadData()
        }
    }
    
    func showLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    //  MARK: Title - VK news
    
    func configureNavBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "VK news"
    }
    
    // MARK: - TableView 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsFeedTableViewCell
        cell.titleLabel.text = news[indexPath.row].postType
        cell.subtitleLabel.text = news[indexPath.row].text
        cell.photoView.set(imageURL: news[indexPath.row].attachments?.first?.photo?.sizes?.first?.url ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNews = news[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    // MARK: - Передаем данные с экрана на экран
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let controller = segue.destination as? DetailViewController {
                controller.news = selectedNews
                selectedNews = nil
            }
        }
    }
     
    // MARK: Подгрузка постов
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height {
            
            if isLoading == false {
                fetchNewsFeed(startFrom)
            }
        }
    }
}

