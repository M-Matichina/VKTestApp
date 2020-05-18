//
//  DetailViewController.swift
//  VKTestApp
//
//  Created by Мария Матичина on 5/18/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var photoView: WebImageView!
    @IBOutlet weak var textView: UITextView!
    
    var news: NewsFeedItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureData()
    }
    
    func configureNavBar() {
        self.title = news?.postType
    }
    
    func configureData() {
        photoView.set(imageURL: news?.attachments?.first?.photo?.sizes?.first?.url ?? "")
        textView.text = news?.text
    }
}
