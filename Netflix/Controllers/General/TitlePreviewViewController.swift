//
//  TitlePreviewViewController.swift
//  Netflix
//
//  Created by Ivan Potapenko on 31.07.2022.
//

import UIKit
import WebKit
import TransitionButton

class TitlePreviewViewController: UIViewController {
    
    private let item:Title
    
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
    
    private let downloadButton: TransitionButton = {
        let button = TransitionButton()
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.spinnerColor = .white
        return button
    }()
    
    private let webView: WKWebView = {
        let view = WKWebView()
        
        return view
    }()
    
    init(item: Title) {
          self.item = item
          super.init(nibName: nil, bundle: nil)
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        downloadButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        downloadButton.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.downloadButton.stopAnimation(animationStyle: .expand, revertAfterDelay: 1) {
                self.downloadTitle()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {
                    self.tabBarController?.selectedIndex = 3
                }
            }
        }
    }
    
    private func downloadTitle() {
        DataPersistenceManager.shared.downloadTitle(with: item) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: Notification.Name("downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
