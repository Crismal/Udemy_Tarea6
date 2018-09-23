//
//  article.swift
//  UdemyWebScrapping
//
//  Created by Cristian Misael Almendro Lazarte on 9/23/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import Foundation

class Article {
    
    var title: String;
    var preview: String;
    var imageUrl: String;
    var postUrl: String;
    
    init(title: String, preview: String, imageUrl: String, postUrl: String) {
        self.title = title;
        self.preview = preview;
        self.imageUrl = imageUrl;
        self.postUrl = postUrl;
    }
}
