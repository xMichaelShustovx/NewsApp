//
//  ViewController.swift
//  NewsApp
//
//  Created by Michael Shustov on 24.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = ArticleModel()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the viewcontroller as the data source and delegate of the table view
        tableView.dataSource = self
        tableView.delegate = self
        
        // Get the articles from the article model
        model.delegate = self
        model.getArticles()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Detect the indexpath the user selected
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            // The user hasn't selected anything
            return
        }
        
        // Get the article the user tapped on
        let article = articles[indexPath!.row]
        
        // Get a reference to the detail view controller
        let detailVC = segue.destination as! DetailViewController
        
        // Pass the article url to the detail view controller
        detailVC.articleUrl = article.url!
    }
}

// MARK: - Table View Protocol Methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        // Customize the cell
        cell.displayArticle(articles[indexPath.row])
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        // User just selected a row, trigger the segue to go to detail
        performSegue(withIdentifier: "goToDetail", sender: self)
        
    }
}

// MARK: - Article Model Protocol Methods
extension ViewController: ArticleModelProtocol {
    
    func articlesRetrived(_ articles: [Article]) {
        
        // Set the articles property of the view controller to the articles passed back from the model
        self.articles = articles
        
        // Refresh the table view
        tableView.reloadData()
        
    }
    
}
