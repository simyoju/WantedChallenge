//
//  MainViewController.swift
//  WantedChallenge
//
//  Created by 뉴링크 on 2023/02/27.
//

import UIKit

import SnapKit
import Then
import Moya
import RxSwift
import RxCocoa
import SwiftyJSON

class LoadButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle("Load", for: .normal)
        backgroundColor = .link
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MainViewController: UIViewController {
    // MARK: - UI
    private let firstImageView = UIImageView().then {
        $0.image = UIImage(systemName: "photo")
    }
    
    private let firstProgressView = UIProgressView().then {
        $0.progress = 0.5
    }
    
    private let firstButton = LoadButton()
    
    private let secondImageView = UIImageView().then {
        $0.image = UIImage(systemName: "photo")
    }
    
    private let secondProgressView = UIProgressView().then {
        $0.progress = 0.5
    }
    
    private let secondButton = LoadButton()
    
    private let thirdImageView = UIImageView().then {
        $0.image = UIImage(systemName: "photo")
    }
    
    private let thirdProgressView = UIProgressView().then {
        $0.progress = 0.5
    }
    
    private let thirdButton = LoadButton()
    
    private let fourthImageView = UIImageView().then {
        $0.image = UIImage(systemName: "photo")
    }
    
    private let fourthProgressView = UIProgressView().then {
        $0.progress = 0.5
    }
    
    private let fourthButton = LoadButton()
    
    private let fifthImageView = UIImageView().then {
        $0.image = UIImage(systemName: "photo")
    }
    
    private let fifthProgressView = UIProgressView().then {
        $0.progress = 0.5
    }
    
    private let fifthButton = LoadButton()
    
    private let bottomButton = LoadButton()
    
    // MARK: - properties
    let provider = MoyaProvider<ImageAPI>()
    
    private lazy var disposeBag = DisposeBag()
    
    let cache = ImageCache.default

    // MARK: - view lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAttribute()
        
        setupView()
        setupLayout()
        setupBinding()
    }
    
    func setupAttribute(){
        view.backgroundColor = .white
        bottomButton.setTitle("Load All Images", for: .normal)
    }
}

private extension MainViewController {
    func setupView(){
        [
            firstImageView, firstProgressView, firstButton,
            secondImageView, secondProgressView, secondButton,
            thirdImageView, thirdProgressView, thirdButton,
            fourthImageView, fourthProgressView, fourthButton,
            fifthImageView, fifthProgressView, fifthButton,
            bottomButton
        ].forEach{
            view.addSubview($0)
        }
    }
    
    func setupLayout(){
        setupFirstLayout()
        setupSecondLayout()
        setupThirdLayout()
        setupFourthLayout()
        setupFifithLayout()
        
        bottomButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(fifthImageView.snp.bottom)
                .offset(8)
            $0.leading.equalTo(firstImageView)
            $0.height.equalTo(firstButton)
        }
    }
    
    func setupFirstLayout(){
        let screenWidth = UIScreen.main.bounds.width
        let imageViewWidth = screenWidth * 0.3
        
        firstImageView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
                .offset(8)
            $0.leading.equalToSuperview()
                .offset(16)
            $0.width.equalTo(imageViewWidth)
            $0.height.equalTo(imageViewWidth * 0.75)
        }
        
        firstProgressView.snp.makeConstraints{
            $0.centerY.equalTo(firstImageView)
            $0.trailing.equalTo(firstButton.snp.leading)
            $0.width.equalTo(imageViewWidth * 1.2)
        }
        
        firstButton.snp.makeConstraints {
            $0.centerY.equalTo(firstImageView)
            $0.trailing.equalToSuperview()
                .inset(16)
            $0.width.equalTo(imageViewWidth * 0.7)
            $0.height.equalTo(imageViewWidth * 0.3)
        }
    }
    
    func setupSecondLayout(){
        secondImageView.snp.makeConstraints{
            $0.top.equalTo(firstImageView.snp.bottom)
                .offset(8)
            $0.leading.width.height.equalTo(firstImageView)
        }
        
        secondProgressView.snp.makeConstraints{
            $0.centerY.equalTo(secondImageView)
            $0.trailing.equalTo(secondButton.snp.leading)
            $0.width.equalTo(firstProgressView)
        }
        
        secondButton.snp.makeConstraints {
            $0.centerY.equalTo(secondImageView)
            $0.trailing.equalTo(firstButton)
            $0.width.height.equalTo(firstButton)
        }
    }
    
    func setupThirdLayout(){
        thirdImageView.snp.makeConstraints{
            $0.top.equalTo(secondImageView.snp.bottom)
                .offset(8)
            $0.leading.width.height.equalTo(firstImageView)
        }
        
        thirdProgressView.snp.makeConstraints{
            $0.centerY.equalTo(thirdImageView)
            $0.trailing.equalTo(thirdButton.snp.leading)
            $0.width.equalTo(firstProgressView)
        }
        
        thirdButton.snp.makeConstraints {
            $0.centerY.equalTo(thirdImageView)
            $0.trailing.equalTo(firstButton)
            $0.width.height.equalTo(firstButton)
        }
    }
    
    func setupFourthLayout(){
        fourthImageView.snp.makeConstraints{
            $0.top.equalTo(thirdImageView.snp.bottom)
                .offset(8)
            $0.leading.width.height.equalTo(firstImageView)
        }
        
        fourthProgressView.snp.makeConstraints{
            $0.centerY.equalTo(fourthImageView)
            $0.trailing.equalTo(fourthButton.snp.leading)
            $0.width.equalTo(firstProgressView)
        }
        
        fourthButton.snp.makeConstraints {
            $0.centerY.equalTo(fourthImageView)
            $0.trailing.equalTo(firstButton)
            $0.width.height.equalTo(firstButton)
        }
    }
    
    func setupFifithLayout(){
        fifthImageView.snp.makeConstraints{
            $0.top.equalTo(fourthImageView.snp.bottom)
                .offset(8)
            $0.leading.width.height.equalTo(firstImageView)
        }
        
        fifthProgressView.snp.makeConstraints{
            $0.centerY.equalTo(fifthImageView)
            $0.trailing.equalTo(fifthButton.snp.leading)
            $0.width.equalTo(firstProgressView)
        }
        
        fifthButton.snp.makeConstraints {
            $0.centerY.equalTo(fifthImageView)
            $0.trailing.equalTo(firstButton)
            $0.width.height.equalTo(firstButton)
        }
    }
extension MainViewController {
    func getImage(page: Int, limit: Int) -> Observable<[String]> {
        KingfisherManager.shared.cache.clearCache()
        
        return Observable.create { emitter in
            self.provider.request(.randomImages(
                page: page,
                limit: limit)) { result in
                    var urls: [String] = []
                    switch result {
                    case .success(let response):
                        let json = JSON(response.data)
                        print("🔫 json: \(json)")
                        print("### json[limit] -> \(json[limit-1])")
                        
                        for data in json.arrayValue {
                            print("### data -> \(data["download_url"].stringValue)")
                            urls.append(data["download_url"].stringValue)
                        }
                        
                        emitter.onNext(urls)
                        emitter.onCompleted()
                    case .failure(let err):
                        print("error 발생 -> \(err.localizedDescription)")
                    }
            }
            return Disposables.create{}
        }
    }
}

