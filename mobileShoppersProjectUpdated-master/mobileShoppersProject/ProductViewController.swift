//
//  ProductViewController.swift
//  mobileShoppersProject
//
//  Created by Yassine Lamtalaa on 5/7/25.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var topDescriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var promoMessageLabel: UILabel!
    @IBOutlet weak var bottomDescriptionLabel: UILabel!
    @IBOutlet weak var imageAspectRatioConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    var product: DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        displayImage(urlString: product?.backgroundImage ?? "")
        topDescriptionLabel.text = product?.topDescription
        titleLabel.text = product?.title
        promoMessageLabel.text = product?.promoMessage
        bottomDescriptionLabel.text = product?.bottomDescription

        guard let contents = product?.content else { return }

        for (index, item) in contents.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(item.title, for: .normal)
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.systemBlue.cgColor
            button.layer.cornerRadius = 8.0
            button.setTitleColor(.systemBlue, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

            buttonStackView.addArrangedSubview(button)
        }

    }
    
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
                self?.productImageView.image = image
                
                NSLayoutConstraint.deactivate([self?.imageAspectRatioConstraint].compactMap { $0 })

                    // Create a new constraint with the actual image size
                    let aspectRatio = image.size.height / image.size.width
                    let newConstraint = self?.productImageView.heightAnchor.constraint(equalTo: self!.productImageView.widthAnchor, multiplier: aspectRatio)
                    newConstraint?.priority = .defaultHigh
                    newConstraint?.isActive = true
                    self?.imageAspectRatioConstraint = newConstraint!
            }
        }.resume()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let product = product else { return }
        let index = sender.tag
        if let urlString = product.content?[index].target,
           let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
