//
//  ViewController.swift
//  RemoteConfig
//
//  Created by Sai Voruganti on 5/16/25.
//

//import UIKit
//
//class ViewController: UIViewController {
//    
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//
//
//}
//
//import UIKit
//import FirebaseRemoteConfig
//
//class ViewController: UIViewController {
//    
//    let remoteConfig = RemoteConfig.remoteConfig()
//    @IBOutlet weak var messageLabel: UILabel!
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Optional: Set fetch interval for development
//        let settings = RemoteConfigSettings()
//        settings.minimumFetchInterval = 0  // fetch every time for testing
//        remoteConfig.configSettings = settings
//        
//        // Fetch remote config
//        fetchRemoteConfig()
//    }
//
//    func fetchRemoteConfig() {
//        remoteConfig.fetchAndActivate { status, error in
//            if status != .error {
//                let message = self.remoteConfig["welcome_message"].stringValue
//                DispatchQueue.main.async {
//                    self.messageLabel.text = message
//                }
//            } else {
//                print("Error fetching remote config: \(error?.localizedDescription ?? "unknown")")
//            }
//        }
//    }
//}


import UIKit
import FirebaseRemoteConfig

class ViewController: UIViewController {

    let remoteConfig = RemoteConfig.remoteConfig()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup remote config settings
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0  // always fetch new values (for testing)
        remoteConfig.configSettings = settings

        // Fetch and apply background color
        fetchBackgroundColor()
    }

    func fetchBackgroundColor() {
        remoteConfig.fetchAndActivate { status, error in
            if let error = error {
                print("Remote Config Fetch failed: \(error.localizedDescription)")
                return
            }

            let color = self.remoteConfig["background_color"].stringValue
            DispatchQueue.main.async {
                if color == "blue" {
                    self.view.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
                    print("Blue")
                } else if color == "gray" {
                    self.view.backgroundColor = UIColor.lightGray
                    print("Gray")
                } else {
                    self.view.backgroundColor = UIColor.white
                }
            }
        }
    }
}
