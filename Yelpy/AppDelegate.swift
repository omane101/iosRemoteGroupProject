//
//  AppDelegate.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import Parse
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("Failed to login with google: ", error)
            return
        }
        print("Successfully signed in google", user)
    }
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let parseConfig = ParseClientConfiguration {
                $0.applicationId = "3GhjILvjyKyp3SxETOMq0ae8UyBYxTES6NHOHcHQ" // <- UPDATE
                $0.clientKey = "4XsXIXZWl3wDem5Ijbj5odYMvVRkwZk4WIBYr3sB" // <- UPDATE
                $0.server = "https://parseapi.back4app.com"
        }
        
        Parse.initialize(with: parseConfig)

        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

    
        return true
    }
    
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return (GIDSignIn.sharedInstance().handle(url))
    }
    
    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//      // Check for errors
//      if let error = error {
//        // handle the error
//        print("Failed to login with Google")
//
//        return
//      }
//
//      guard let authentication = user.authentication else { return }
//      guard let idToken = user.authentication.idToken else { return }
//      guard let accessToken = user.authentication.accessToken else {return}
//      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                        accessToken: authentication.accessToken)
//      // login with the credentials
//
//        Auth.auth().signIn(with: credential) { (authResult, error) in
//            if let error = error {
//                print("Failed to login with Google")
//                return
//            }
//            print("Successfully logged in")
//
//
//    }

    
    
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


