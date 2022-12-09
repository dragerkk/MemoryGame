//
//  MainViewController.swift
//  6_MemoryGame
//
//  Created by 강주원 on 2022/07/11.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import Alamofire

class MainViewController: UIViewController {

	@IBOutlet weak var kakaoLoginButton: UIButton!
	@IBOutlet weak var naverLoginButton: UIButton!
	@IBOutlet weak var logoutButton: UIButton!
	
	let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
	
	var loginWith: String = ""
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		logoutButton.isHidden = true

        // Do any additional setup after loading the view.
    }
	
	// MARK: - Kakao Login
	@IBAction func kakaoLoginAction(_ sender: Any) {
		if (UserApi.isKakaoTalkLoginAvailable()) {
			UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
				if let error = error {
					print(error)
				}
				else {
					print("loginWithKakaoTalk() success.")
					_ = oauthToken
					self.changesWhenLogin()
					
					self.loginWith = "kakao"
				}
			}
		}
	}
	
	// MARK: - Naver Login
	@IBAction func naverLoginAction(_ sender: Any) {
		naverLoginInstance?.requestThirdPartyLogin()
		print("naver login success")
		
		self.changesWhenLogin()
		self.loginWith = "naver"
	}
	
	
	// MARK: - Logout
	
	@IBAction func logoutAction(_ sender: Any) {
		if loginWith == "kakao" {
			UserApi.shared.logout {(error) in
				if let error = error {
					print(error)
				} else {
					print("kakao logout")
					self.changesWhenLogout()
				}
			}
		} else if loginWith == "naver" {
			naverLoginInstance?.requestDeleteToken()
			print("naver logout")
			self.changesWhenLogout()
		}
	}
}


extension MainViewController {
	
	func changesWhenLogin() {
		self.kakaoLoginButton.isHidden = true
		self.naverLoginButton.isHidden = true
		self.logoutButton.isHidden = false
	}
	
	func changesWhenLogout() {
		self.logoutButton.isHidden = true
		self.kakaoLoginButton.isHidden = false
		self.naverLoginButton.isHidden = false
		self.loginWith = ""
	}

}
