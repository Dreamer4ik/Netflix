//
//  LogoPresentViewController.swift
//  Netflix
//
//  Created by Ivan Potapenko on 20.07.2022.
//

import UIKit

class LogoPresentViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.animate()
        }
    }
    
    private func animate() {
        UIView.animate(withDuration: 1) {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
            
        }
        
        UIView.animate(withDuration: 1, animations: {
            
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                    let mainAppTabBarVC = MainTabBarViewController()
                    mainAppTabBarVC.modalTransitionStyle = .crossDissolve
                    mainAppTabBarVC.modalPresentationStyle = .fullScreen
                    self.present(mainAppTabBarVC, animated: true)
                }
            }
        })
        
    }
    
}
