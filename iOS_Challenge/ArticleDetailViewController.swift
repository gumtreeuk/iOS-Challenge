//
//  ArticleDetailViewController.swift
//  iOS_Challenge
//
//  Created by Hassan, Waseem(eCG) on 07/03/2022.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!

    var article: Article?
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = article?.body
        titleLabel.text = article?.headline
        
        if let article = article {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: article.imageURL)  {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }

}
