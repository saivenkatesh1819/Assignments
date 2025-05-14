import UIKit

class GridViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var products: [DataModel] = []
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        networkManager.delegate = self
        networkManager.performApiCall()
    }
}

extension GridViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridViewCell", for: indexPath) as? GridViewCell else {
            return UICollectionViewCell()
        }
        let product = products[indexPath.row]
        cell.textFieldLabel.text = product.title
        cell.displayImage(urlString: product.backgroundImage)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
            vc.product = products[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension GridViewController: ViewControllerProtocol {
    func refreshUI(with response: [DataModel]) {
        DispatchQueue.main.async {
            self.products = response
            self.collectionView.reloadData()
        }
    }
}
