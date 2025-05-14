//
//  ViewController.swift
//  Location
//
//  Created by Sai Voruganti on 5/8/25.
//



import UIKit
import CoreLocation


class ViewController: UIViewController {
    @IBOutlet weak var locLabel: UILabel!
    let locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.onLocationUpdate = { [weak self] lat, lon in
            let text = "Lat: \(lat), Long: \(lon)"
            DispatchQueue.main.async {
                self?.locLabel.text = text
            }
        }
    }
    @IBAction func locButtonTapped(_ sender: Any) {
        locationManager.startUpdating()
    }
    
    
}
