//
//  AppDelegate.swift
//  MovieCase
//
//  Created by Eren Üstünel on 13.03.2022.
//

import UIKit
import Firebase
import FirebaseMessaging
import netfox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.Message_ID"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        NFX.sharedInstance().start()
        setUpStartView()
        return true
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)
                        -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    private func setUpStartView() {
        let vc = SplashVC(nibName: "SplashVC", bundle: nil)
        let navController = UINavigationController(rootViewController: vc)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
    
    
}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                // burada backend tarafına geçerli token bilginizi yollayabilirsiniz
            }
        }
    }
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {

    private func setupAPN(_ application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { authorized, _ in
              if authorized {
                DispatchQueue.main.async(execute: {
                    application.registerForRemoteNotifications()
                })
              }
            })
    }

  // This function will be called when the app receive notification
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

    let application = UIApplication.shared

      if application.applicationState == .active {
        print("user tapped the notification bar when the app is in foreground")
      }

      if application.applicationState == .inactive {
        print("user tapped the notification bar when the app is in background")
      }

      /* Change root view controller to a specific viewcontroller */
      // self.window?.rootViewController = specific viewcontroller
    let userInfo = notification.request.content.userInfo
    // burada deeplink ayarlarınızı yapıp ekran yönlendirmelerinizi sağlayabilirsiniz
    //startWithDeeplink(userInfo)
    Messaging.messaging().appDidReceiveMessage(userInfo)
    completionHandler([.alert, .sound])
  }

  // This function will be called right after user tap on the notification
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

    // tell the app that we have finished processing the user’s action / response
    let userInfo = response.notification.request.content.userInfo
    // burada deeplink ayarlarınızı yapıp ekran yönlendirmelerinizi sağlayabilirsiniz
    //startWithDeeplink(userInfo)
    completionHandler()
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenStr = convertDeviceTokenToString(deviceToken: deviceToken as NSData)
        print("APNs token retrieved: \(deviceTokenStr)")
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
  }
  
  fileprivate func convertDeviceTokenToString(deviceToken: NSData) -> String {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        return token
  }
  
}
