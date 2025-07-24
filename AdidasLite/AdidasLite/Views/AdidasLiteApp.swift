//
//  AdidasLiteApp.swift
//  AdidasLite
//
//  Created by Sai Voruganti on 7/1/25.
//
import SwiftUI
import StripeCore
import FirebaseCore
import FirebaseMessaging
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        // Set delegates
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        // Ask for push notification permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("❌ Notification permission error: \(error.localizedDescription)")
            } else {
                print("✅ Notification permission granted: \(granted)")
            }
        }
        
        // Register with APNs
        application.registerForRemoteNotifications()
        
        return true
    }

    // Called when APNs token is received
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        print("✅ APNs token received")
    }

    // Called when FCM token is refreshed or initially issued
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let token = fcmToken {
            print("🔥 FCM Token: \(token)")
            // You can send this token to your backend for targeted notifications
        }
    }

    // Handle notifications in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}

@main
struct AdidasLiteApp: App {
    init() {
        StripeAPI.defaultPublishableKey = "pk_test_51RjPHXRuYJaM4uYeS1R0VryCznn7UfIt9c8po6PqZSZsu7BUTbYMql6X7GBfEvzdhSuq2CWV9FY7KSLUIzZVEoYl007p5nHy4G"
    }

    @StateObject private var authVM = AuthViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if authVM.isLoggedIn {
                    ProductListView()
                } else {
                    LoginView()
                        .environmentObject(authVM)
                }
            }
        }
    }
}
