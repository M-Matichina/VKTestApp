//
//  NewsFeedController.swift
//  VKTestApp
//
//  Created by Мария Матичина on 5/17/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {

    private var fetcher: DataFetcher = NetworkingNewsFeedFetcher(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .blue
        fetcher.getNewsFeed { (newsFeedResponse) in
            guard let newsFeedResponse = newsFeedResponse else { return }
            newsFeedResponse.items.map ({ (newsFeedItem) in
                print(newsFeedItem.date)
            })
        }
    }
}
