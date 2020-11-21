Unit 8: Group Milestone - README Example
===

# Real Time Foot Traffic Application

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)

## Overview
### Description
RTFT is a Yelp like application that can allow users to view recent reviews of businesses and provide real time updates as to the current foot traffic at that business using crowd-sourced

### App Evaluation
- **Category:** Social Networking / Food
- **Mobile:** This app would be primarily developed for mobile.
- **Story:** Users will see a list of Restaurants within a certain radius with foot traffic levels. Users can also vote on the level if they are currently at that location.
- **Market:** Individuals looking for places that may have lower waiting times or that are less busy and thus less of a virus-risk.
- **Habit:** This app could be used as often as the user goes out to eat. 
- **Scope:** First the app would be limited to the list of restaurants provided. On a larger scope it would branch beyone restuarants to other businesses like bars, lounges etc.

## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**

*Be able to go to a profile page and customize it
*Be able to generate a list of places within a radius of location 
*Be able to vote either: too busy, not busy, or any other button ideas
*Ability to quickly give 1-5 stars for business
*View the current foot traffic level/check-in feature to count
*Ability to offer more in depth review


**Optional Nice-to-have Stories**

*Have special reviews for covid related matter
*Chat ability 


### 2. Screen Archetypes

* Login 
* Register - User signs up or logs into their account
   * Upon Download/Reopening of the application, the user is prompted to log in to gain access to their profile information to be properly matched with another person. 
* List of Places Screen
  *...
* Detailed view of Places Screen
  *...
* Profile Screen 
   * Allows user to upload a photo and fill in information that is interesting to them and others

* Settings Screen
   * Lets people change language, and app notification settings.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* List of Places
* Profile

**Flow Navigation** (Screen to Screen)
* Forced Log-in -> Account creation if no log in is available


## Wireframes
<img src="https://i.imgur.com/IdvEUEI.png" width=800><br>

# Networking
### 1.	Login Page

## Authentication with google account

pod 'Firebase/Auth'
pod 'GoogleSignIn'

##  In your app delegate, import the following header files:

import Firebase
import GoogleSignIn

##  In the view controller of your sign-in view, import the following header files:

import Firebase
import GoogleSignIn

 ##  In the app delegate, implement the GIDSignInDelegate protocol to handle the sign-in process by defining the following methods:

func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
  // ...
  if let error = error {
    // ...
    return
  }

  guard let authentication = user.authentication else { return }
  let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                    accessToken: authentication.accessToken)
  // ...
}

func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
    // Perform any operations when the user disconnects from app here.
    // ...
}

##  In the view controller, override the viewDidLoad method to set the presenting view controller of the GIDSignIn object, and (optionally) to sign in silently when possible.

GIDSignIn.sharedInstance()?.presentingViewController = self
GIDSignIn.sharedInstance().signIn()

##  In the signIn:didSignInForUser:withError: method, get a Google ID token and Google access token from the GIDAuthentication object and exchange them for a Firebase credential

func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
  // ...
  if let error = error {
    // ...
    return
  }

  guard let authentication = user.authentication else { return }
  let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                    accessToken: authentication.accessToken)
  // ...
}

##  Finally, authenticate with Firebase using the credential:

Auth.auth().signIn(with: credential) { (authResult, error) in
  if let error = error {
    let authError = error as NSError
    if (isMFAEnabled && authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
      // The user is a multi-factor user. Second factor challenge is required.
      let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
      var displayNameString = ""
      for tmpFactorInfo in (resolver.hints) {
        displayNameString += tmpFactorInfo.displayName ?? ""
        displayNameString += " "
      }
      self.showTextInputPrompt(withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK, displayName in
        var selectedHint: PhoneMultiFactorInfo?
        for tmpFactorInfo in resolver.hints {
          if (displayName == tmpFactorInfo.displayName) {
            selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
          }
        }
        PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil, multiFactorSession: resolver.session) { verificationID, error in
          if error != nil {
            print("Multi factor start sign in failed. Error: \(error.debugDescription)")
          } else {
            self.showTextInputPrompt(withMessage: "Verification code for \(selectedHint?.displayName ?? "")", completionBlock: { userPressedOK, verificationCode in
              let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode!)
              let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
              resolver.resolveSignIn(with: assertion!) { authResult, error in
                if error != nil {
                  print("Multi factor finanlize sign in failed. Error: \(error.debugDescription)")
                } else {
                  self.navigationController?.popViewController(animated: true)
                }
              }
            })
          }
        }
      })
    } else {
      self.showMessagePrompt(error.localizedDescription)
      return
    }
    // ...
    return
  }
  // User is signed in
  // ...
}

## Sign out
To sign out a user, call signOut:.

      let firebaseAuth = Auth.auth()
do {
  try firebaseAuth.signOut()
} catch let signOutError as NSError {
  print ("Error signing out: %@", signOutError)
}
  
  
### Get the currently signed-in user : The recommended way to get the current user is by setting a listener on the Auth object:

handle = Auth.auth().addStateDidChangeListener { (auth, user) in
  // ...
}

#### By using a listener, you ensure that the Auth object isn't in an intermediate state—such as initialization—when you get the current user. You can also get the currently signed-in user by using the currentUser property. If a user isn't signed in, currentUser is nil:

if Auth.auth().currentUser != nil {
  // User is signed in.
  // ...
} else {
  // No user is signed in.
  // ...
}

## 2. Profile Page:
# Get a user's profile

let user = Auth.auth().currentUser
if let user = user {
  // The user's ID, unique to the Firebase project.
  // Do NOT use this value to authenticate with your backend server,
  // if you have one. Use getTokenWithCompletion:completion: instead.
  let uid = user.uid
  let email = user.email
  let photoURL = user.photoURL
  var multiFactorString = "MultiFactor: "
  for info in user.multiFactor.enrolledFactors {
    multiFactorString += info.displayName ?? "[DispayName]"
    multiFactorString += " "
  }
  // ...
}




