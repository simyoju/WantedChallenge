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
    private let firstImageView = UIImageView().then {
        $0.image = UIImage(systemName: "photo")
    }
    
    private let firstProgressView = UIProgressView().then {
        $0.progress = 0.5
    }
    
    private let firstButton = UIButton().then {
        $0.setTitle("Load", for: .normal)
        $0.backgroundColor = .link
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
        setupView()
        setupLayout()
    }
}

private extension MainViewController {
    func setupView(){
        [
            firstImageView, firstProgressView, firstButton
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
        
        firstProgressView.snp.makeConstraints{
            $0.centerY.equalTo(firstImageView)
            $0.leading.equalTo(firstImageView.snp.trailing)
                .offset(8)
            $0.width.equalTo(imageViewWidth)
        }
        
        firstButton.snp.makeConstraints {
            $0.centerY.equalTo(firstImageView)
            $0.leading.equalTo(firstProgressView.snp.trailing)
            $0.width.equalTo(imageViewWidth)
            $0.height.equalTo(imageViewWidth * 0.5)
        }
    }
}

