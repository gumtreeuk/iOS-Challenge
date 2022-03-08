//
//  HomeViewController.swift
//  iOS_Challenge
//
//  Created by Hassan, Waseem(eCG) on 07/03/2022.
//

import UIKit
import Network
import Foundation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var articleArray = [Article]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadArticles()
    }
    
    
    func loadArticles() {
        let api = Network()
        
        api.loadRequest { result in
            switch result {
            case .success(let data):
                self.parseData(data: data)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func parseData(data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let response = json["response"] as? [String: Any],
           let results = response["results"] as? [[String: Any]] {
            for articleData in results {
                let article = Article()
                article.headline = articleData["webTitle"] as? String ?? ""
                article.date = articleData["webPublicationDate"] as? String ?? ""
                if let fields = articleData["fields"] as? [String: String] {
                    article.body = stripTags(str: fields["body"] ?? "")
                    if let url = getURL(str: fields["main"]) {
                        article.imageURL = url
                    }
                    
                } else {
                    article.body = ""
                }

                articleArray.append(article)
            }
        }
        
        tableView.reloadData()
    }
    
    func stripTags(str: String) -> String {
        var result = str.replacingOccurrences(of: "</p> <p>", with: "\n\n") as NSString
        var range = result.range(of: "<[^>]+>", options: .regularExpression)
        while range.location != NSNotFound {
            result = result.replacingCharacters(in: range, with: "") as NSString
            range = result.range(of: "<[^>]+>", options: .regularExpression)
        }
        return result as String
    }
    
    func getURL(str: String?) -> URL? {
        guard let str = str,
                let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return nil }
        let matches = detector.matches(in: str, options: [], range: NSRange(location: 0, length: (str as NSString).length))
        if let url = matches.first?.url {
            return url
        }
        
        return nil
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")  else {
            return UITableViewCell()
        }
        
        let article = articleArray[indexPath.row]
        cell.textLabel?.text = article.headline
        cell.detailTextLabel?.text = article.date
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: article.imageURL)  {
                cell.imageView?.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ArticleDetailViewController(nibName: "ArticleDetailViewController", bundle: nil)
        vc.article = articleArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

