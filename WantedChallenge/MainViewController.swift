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
    // MARK: - properties
    let provider = MoyaProvider<ImageAPI>()
    
    private lazy var disposeBag = DisposeBag()

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

