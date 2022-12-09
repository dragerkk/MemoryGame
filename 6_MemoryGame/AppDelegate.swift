//
//  AppDelegate.swift
//  6_MemoryGame
//
//  Created by 강주원 on 2022/07/05.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var orientationLock = UIInterfaceOrientationMask.portrait

	// MARK: - Set orientation : Portrait
	func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
		return self.orientationLock
	}

	// MARK: - kakao SDK initialize
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		//kakao
		KakaoSDK.initSDK(appKey: "bbf5e0e07e51e75b041766bfa54b290d")
		
		// naver
		let instance = NaverThirdPartyLoginConnection.getSharedInstance()
		
		instance?.isNaverAppOauthEnable = true
		instance?.isInAppOauthEnable = true
		
		instance?.isOnlyPortraitSupportedInIphone()
		
		instance?.serviceUrlScheme = kServiceAppUrlScheme
		instance?.consumerKey = kConsumerKey
		instance?.consumerSecret = kConsumerSecret
		instance?.appName = kServiceAppName
		return true
	}
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
		
		NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
		return true
	}
	
//	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//		if (AuthApi.isKakaoTalkLoginUrl(url)) {
//			return AuthController.handleOpenUrl(url: url)
//		}
//		
//		return false
//	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}

