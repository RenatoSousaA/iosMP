//
//  AppDelegate.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 04/10/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

import Fabric
import Crashlytics
import Firebase

import didm_auth_sdk_iOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SdkSupportVersionResposeDelegate {
    
    static var tokenInstance: DetectID?
    
    static var helpText: String = ""
    static var readingErrorMessage: String = ""

    var window: UIWindow?
    
    var restrictRotation: UIInterfaceOrientationMask = .portrait

    var viewController: CommonViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                
        Fabric.with([Crashlytics.self])
        
        FirebaseApp.configure()
        
        self.setupDefaultMessages()
        
        self.initDetectID()
        
        self.setupWindow()
        
        return true
    }
    
    private func setupDefaultMessages() {
        
        self.setupHelpMessage()
        self.setupReadingErrorMessage()
    }
    
    private func setupReadingErrorMessage() {
        
        AppDelegate.readingErrorMessage = "Ocorreu algum problema.\n\nApenas a função \"GERAR CÓDIGO TOKEN\" está disponível neste momento.\n\nSe preferir, feche e abra o aplicativo novamente."
    }
    
    private func setupHelpMessage() {
        
        AppDelegate.helpText = "LER CÓDIGO DE BARRAS: Clique nesta opção e aproxime a câmera do celular do código de barras do boleto do fornecedor.\n\nGERAR CÓDIGO TOKEN: Use para acessar o Portal TOTVS Mais Prazo, confirmar Solicitação de Pagamento ou alterar os dados cadastrais"
    }
    
    func initDetectID() {
        
        AppDelegate.tokenInstance = DetectID.sdk() as? DetectID
        
        let url = "https://id.suppliermais.com.br/detect/public/registration/mobileServices.htm?code="

        let params = InitParamsBuilder.init()?
            .buildDidUrl(url)?
            .buildSdkSupportedDelegate(self)
            .buildParams()
        
        AppDelegate.tokenInstance?.initDIDServer(with: params)
        
    }
    
    func onSuccessResponse(_ supported: Bool) {
        // DetectID required callback
    }
    
    func onFailedResponse() {
        // DetectID required callback
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.restrictRotation
    }
    
    private func setupWindow() {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
//        self.viewController = TokenViewController()
        self.viewController = ActivationViewController()
//        self.viewController = HomeViewController()
//        self.viewController = ActivationDoneViewController()
        
        let navController: UINavigationController = UINavigationController.init(rootViewController: self.viewController!)
        
        self.viewController?.modalPresentationStyle = .overCurrentContext
        
        self.window?.backgroundColor = .clear
        self.window?.rootViewController = navController
        
        self.window?.makeKeyAndVisible()
        
    }

}

