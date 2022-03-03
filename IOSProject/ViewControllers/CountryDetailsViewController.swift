//
//  CountryDetailsViewController.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

import UIKit

class CountryDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countrynameLabel: UILabel!
    
    var country:Country?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = country?.flag else { return }
        
        imageView.downloaded(from: url)
        countrynameLabel.text = country?.name.capitalized
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
