//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Michael Shustov on 24.10.2021.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay: Article?
    
    func displayArticle(_ article: Article) {
        
        // Clean up the cell before displaying the next article
        headlineLabel.text = ""
        headlineLabel.alpha = 0
        articleImageView.image = nil
        articleImageView.alpha = 0
        
        // Keep the reference to the article
        articleToDisplay = article
        
        // Set the headline
        headlineLabel.text = articleToDisplay!.title
        
        // Animate the label into view
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            
            self.headlineLabel.alpha = 1
            
        }, completion: nil)
        
        // Download and display the image
        
        // Check the article has an image
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        // Create url string
        let stringUrl = articleToDisplay!.urlToImage
        
        // Check the cache manager before downloading any image data
        if let imageData = CacheManager.retrieveData(stringUrl!) {
            
            DispatchQueue.main.async {
                self.articleImageView.image = UIImage(data: imageData)
                
                // Animate the image into view
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                    
                    self.articleImageView.alpha = 1
                    
                }, completion: nil)
            }

            return
        }
        
        // Create url object
        let url = URL(string: stringUrl!)
        
        // Check that url isn't nil
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        
        // Get a URLSession
        let session = URLSession.shared
        
        // Create a data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                
                // Save the data into cache
                CacheManager.saveData(stringUrl!, data!)
                
                // Check if the url string that the data task went off to download matches the article this cell is set to display
                if self.articleToDisplay!.urlToImage == stringUrl {
                    
                    DispatchQueue.main.async {
                        // Display the image data in the image view
                        self.articleImageView.image = UIImage(data: data!)
                        
                        // Animate the image into view
                        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                            
                            self.articleImageView.alpha = 1
                            
                        }, completion: nil)
                    }
                }
            }
        }
        
        // Start the data task
        dataTask.resume()
        
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
