//
//  APIProvider.swift
//  KinopoiskApp
//
//  Created by Nikita Yazikov on 08.02.2020.
//  Copyright © 2020 Nikita Yazikov. All rights reserved.
//

import Foundation
import Moya

enum APIProvider {
    case getFilms
}

extension APIProvider: TargetType {
    var baseURL: URL {
        switch self {
        case .getFilms:
            return URL(string: APIConfig.filmsURL)!
        }
    }
    
    var path: String {
        switch self {
        case .getFilms:
            return "/sequeniatesttask/films.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getFilms:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getFilms:
            return Data()
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .getFilms:
            return URLEncoding.default
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .getFilms:
            return [:]
        }
    }
    
    var task: Task {
        switch self {
        case .getFilms:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getFilms:
            return [:]
        }
    }
}
