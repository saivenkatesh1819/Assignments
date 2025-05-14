//
//  ProductTableViewCell.swift
//  mobileShoppersProject
//
//  Created by Yassine Lamtalaa on 5/7/25.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var textFieldLabel: UILabel!
    
    func displayImage(urlString: String) {
        var imageUrlString = urlString
        if imageUrlString.hasPrefix("http://") {
            imageUrlString = imageUrlString.replacingOccurrences(of: "http://", with: "https://")
        }
        guard let url = URL(string: imageUrlString) else {
            print("Invalid URL")
            return
        }
        
        // Fetch the image data in the background
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error loading image: \(error)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                print("Couldn't load image data")
                return
            }
            
            // Update UI on the main thread
            DispatchQueue.main.async {
                self?.mainImageView.image = image
            }
        }.resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
