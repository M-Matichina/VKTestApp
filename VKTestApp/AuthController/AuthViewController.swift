//
//  ViewController.swift
//  VKTestApp
//
//  Created by Мария Матичина on 5/15/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        authService = AuthService()
        authService.wakeUpSession { (accessToken) in
            if accessToken != nil {
                
                // MARK: Переход на NewsFeedController, который находится на storyboard NewsFeedViewController
                
                let storyboard = UIStoryboard(name: "NewsFeed", bundle: nil)
                let controller = storyboard.instantiateViewController(identifier: "NewsFeedViewController")
                controller.modalPresentationStyle = .fullScreen
                
                guard let window = UIApplication.shared.keyWindow else {
                    return
                }
                
                let root = UINavigationController()
                root.viewControllers = [controller]
                
                UIView.transition(with: window, duration: 0.0, options: .transitionCrossDissolve, animations: {
                    window.rootViewController = root
                }, completion: nil)
                
            } else {
                print(Error.self)
            }
        }
    }
}

