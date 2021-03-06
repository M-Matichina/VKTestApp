//
//  AuthService.swift
//  VKTestApp
//
//  Created by Мария Матичина on 5/15/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import Foundation
import VKSdkFramework

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "7467537"
    private let vkSdk: VKSdk
    private var loginWindow: UIWindow? // Окно входа
    
    private var tokenCallBack: ((_ accessToken: String) -> Void)?
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init() 
        print("VKSdk.initialize") // Показываем, что инициализация завершилась
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    
    // MARK:- Права доступа для токена пользователя
    
    func wakeUpSession(_ completion: @escaping (_ accessToken: String?) -> Void) {
        tokenCallBack = completion // Вовзрат token когда прошли авторизацию
       
        let scope = ["friends, wall"]
        
//        VKSdk.forceLogout()
        
        VKSdk.wakeUpSession(scope) { (state, error) in
            switch state { // state - нынешнее состояние
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
                completion(VKSdk.accessToken().accessToken)
            default:
                completion(nil)
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    
    // MARK:- func от VKSdkDelegate, VKSdkUIDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) { // Авторизация доступа успешно завершена
        print(#function)
        tokenCallBack?(result.token.accessToken)
    }
    
    func vkSdkUserAuthorizationFailed() { // Авторизация пользователя не удалась
        print(#function)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) { // Должен показать UIViewController
        
        controller.modalPresentationStyle = .overFullScreen
        createLoginWindow()?.rootViewController?.present(controller, animated: true)
        // present - появление экрана снизу вверх
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) { // Нужен защитный код входа (код с картинки)
        print(#function)
    }
    
    
    // MARK:- Создаем окно входа
    
    func createLoginWindow() -> UIWindow? { // UIWindow - это контейнер, содержащий UIViewController
        
        loginWindow = UIWindow(frame: UIScreen.main.bounds) // Соответ.размерам экрана тел.
        loginWindow?.rootViewController = UIViewController() // Создан UIViewController в качестве rootViewController для контейнера
        
        loginWindow?.makeKeyAndVisible()
        
        return loginWindow
    }
}



