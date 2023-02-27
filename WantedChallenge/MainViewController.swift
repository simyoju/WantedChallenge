//
//  MainViewController.swift
//  WantedChallenge
//
//  Created by 뉴링크 on 2023/02/27.
//

import UIKit

import SnapKit
import Then

class MainViewController: UIViewController {
    // MARK: - UI
    let firstImageView = UIImageView().then {
        $0.image = UIImage(systemName: "photo")
    }
    
//    let firstProgressBar = 

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
        setupView()
        setupLayout()
    }
}

extension MainViewController {
    func setupView(){
        [
            firstImageView
        ].forEach{
            view.addSubview($0)
        }
    }
    
    func setupLayout(){
        let screenWidth = UIScreen.main.bounds.width
        let imageViewWidth = screenWidth * 0.3
        
        firstImageView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
                .offset(8)
            $0.leading.equalToSuperview()
                .offset(24)
            $0.width.equalTo(imageViewWidth)
            $0.height.equalTo(imageViewWidth * 0.75)
        }
    }
}

