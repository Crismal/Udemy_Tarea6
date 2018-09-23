//
//  articleFactory.swift
//  UdemyWebScrapping
//
//  Created by Cristian Misael Almendro Lazarte on 9/23/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import Foundation
import Alamofire
import Kanna

class ArticleFactory {
    
    var articles = [Article]();
    
    var articleUrl: String;
    
    init(articleUrl: String) {
        self.articleUrl = articleUrl;
        self.scrapeURL();
    }
    
    
    func scrapeURL() {
        
        Alamofire.request(self.articleUrl).responseString { (response ) in
            
            if response.result.isSuccess{
                if let htmlString = response.result.value{
                    self.parseHtml(html: htmlString);
                }
            }
            
        };
    }
    
    func parseHtml(html: String) {
        //print(html);
        
        do {
            
            //Procesado con Kanna
            let doc = try Kanna.HTML(html: html, encoding: String.Encoding.utf8);
            
            var title : String = ""
            var preview : String = ""
            var imageUrl : String = ""
            var postUrl : String = ""
            
            for article in doc.css("article") {
                
                for h2 in article.css("h2"){
                    title = h2.text!.trimmingCharacters(in: .whitespacesAndNewlines);
                    break;
                }
                
                for p in article.css("p"){
                    preview = p.text!;
                    break;
                }
                
                for a in article.css("a"){
                    if a["class"] == "more-link"{
                        postUrl = a["href"]!;
                        break;
                    }
                }
                
                for img in article.css("img"){
                    imageUrl = img["src"]!;
                    break;
                }
                
                let art = Article(title: title, preview: preview, imageUrl: imageUrl, postUrl: postUrl)
                
                self.articles.append(art);
                
                
                NotificationCenter.default.post(name: NSNotification.Name("articlesUpdated") , object: nil);
            }
        } catch  {
            print(error);
        }
    }
    
}
