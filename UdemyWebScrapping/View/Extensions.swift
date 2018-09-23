//
//  Extensions.swift
//  UdemyWebScrapping
//
//  Created by Cristian Misael Almendro Lazarte on 9/23/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func downloadFrom(link: String, contentMode Mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else {
            return;
        }
        downloadFrom(url: url);
    }
    
    
    func downloadFrom(url: URL, contentMode Mode: UIView.ContentMode = .scaleAspectFill) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else{
                    return;
                }
            
            DispatchQueue.main.async {
                self.image = image;
            }
            }.resume();
    }
}
