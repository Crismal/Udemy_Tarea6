//
//  ViewController.swift
//  UdemyWebScrapping
//
//  Created by Cristian Misael Almendro Lazarte on 9/16/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

import SafariServices

class ViewController : UICollectionViewController{
    
    let urlPage = "http://juangabrielgomila.com/blog/";
    
    var factory : ArticleFactory!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadItemsInCollectionView), name: NSNotification.Name("articlesUpdated"), object: nil);
        
        factory = ArticleFactory(articleUrl: urlPage);
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return factory.articles.count;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell;
        
        
        cell.title.text =  factory.articles[indexPath.row].title;
        
        cell.preview.text =  factory.articles[indexPath.row].preview;
        cell.imageView.downloadFrom(link: factory.articles[indexPath.row].imageUrl)
        
        print(cell.title.text);
        
        return cell;
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openUrlWithSafariVC(self.factory.articles[indexPath.row].postUrl)
    }
    
    @objc func reloadItemsInCollectionView() {
        self.collectionView.reloadData();
    }
}

typealias SafariDelegate = ViewController
extension SafariDelegate : SFSafariViewControllerDelegate {
    
    fileprivate func openUrlWithSafariVC(_ urlstring:String) {
        let sfvc = SFSafariViewController(url: URL(string: urlstring)!, entersReaderIfAvailable: true)
        sfvc.delegate = self
        self.present(sfvc, animated: true, completion: nil)
    }
}
