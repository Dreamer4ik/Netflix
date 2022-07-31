//
//  TitlePreviewViewController.swift
//  Netflix
//
//  Created by Ivan Potapenko on 31.07.2022.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let webView: WKWebView = {
        let view = WKWebView()
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = CGRect(
            x: 0,
            y: 50,
            width: view.width,
            height: 300
        )
        
        titleLabel.frame = CGRect(
            x: 20,
            y: webView.bottom + 20,
            width: view.width,
            height: 30
        )
        overviewLabel.sizeToFit()
        let overviewLabelSize = overviewLabel.sizeThatFits(CGSize(width: view.width - 40, height: view.height))
        overviewLabel.frame = CGRect(
            x: 20,
            y: titleLabel.bottom + 15,
            width: view.width - 40,
            height: overviewLabelSize.height
        )
        
        downloadButton.frame = CGRect(
            x: (view.width - 140)/2 ,
            y: overviewLabel.bottom + 25,
            width: 140,
            height: 40
        )
    }
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
}
