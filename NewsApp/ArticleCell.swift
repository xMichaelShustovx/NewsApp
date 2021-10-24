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
        articleImageView.image = nil
        
        // Keep the reference to the article
        articleToDisplay = article
        
        // Set the headline
        headlineLabel.text = articleToDisplay!.title
        
        // Download and display the image
        
        // Check the article has an image
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        // Create url string
        let stringUrl = articleToDisplay!.urlToImage
        
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
                
                // Check if the url string that the data task went off to download matches the article this cell is set to display
                if self.articleToDisplay!.urlToImage == stringUrl {
                    
                    DispatchQueue.main.async {
                        // Display the image data in the image view
                        self.articleImageView.image = UIImage(data: data!)
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