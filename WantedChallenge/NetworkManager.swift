//
//  NetworkManager.swift
//  WantedChallenge
//
//  Created by 심효주 on 2023/03/02.
//

import Foundation
import Moya

enum ImageAPI {
    case randomImages(
        page: Int,
        limit: Int
    )
}

extension ImageAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://picsum.photos")!
    }
    
    var path: String {
        return "/v2/list"
        // ?page=2&limit=100
    }
    
    var method: Moya.Method {
        switch self {
        case .randomImages:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .randomImages(
            let page,
            let limit
        ):
            return .requestParameters(parameters: [
                "page" : page,
                "limit" : limit
            ], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

