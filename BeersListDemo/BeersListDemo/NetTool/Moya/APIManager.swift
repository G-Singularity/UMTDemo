//
//  APIManager.swift
//  BeersListDemo
//
//  Created by dqh on 8/8/23.
//

import Moya

//let kBaseURL = "https://api.punkapi.com/v2"

enum API {
    //All
    case all
    //用户信息
    case userInfo(_ access_token: String, _ uid: Int64)
    //获取当前登录用户及其所关注（授权）用户的最新微博
    case homeTimeline(_ access_token: String, _ since_id: Int64, _ max_id: Int64)
    //首页列表
    case list
    //发微博
    case compose(_ access_token: String, _ status: String)
}

// MARK: - 补全【MoyaConfig 3：配置TargetType协议可以一次性处理的参数】中没有处理的参数
extension API: TargetType {
//    //0. 基础域名，整个项目只用一个，可以写在MoyaConfig中
//    var baseURL: URL {
//        switch self {
//        case .oauth:
//            return URL(string: kBaseURL)!
//        default:
//            return URL(string: kBaseURL)!
//        }
//    }
    
    //1. 每个接口的相对路径,  请求时的绝对路径是：baseURL + path
    var path: String {
        switch self {
        case .all:
            return "beers"
        case .userInfo:
            return "2/users/show.json"
        case .homeTimeline:
            return "statuses/home_timeline.json"
        case .list:
            return "statuses/home_timeline"
        case .compose:
            return "wiki/2/statuses/update"
        }
    }
    
    //2. 每个接口要使用的请求方式
    var method: Moya.Method {
        switch self {
        case .all:
            return .get
        case .userInfo( _, _):
            return .get
        case .homeTimeline( _, _, _):
            return .get
        case .list:
            return .get
        case .compose( _, _):
            return .post
        }
        
    }
    
    //3. Task是一个枚举值，根据后台需要的数据，选择不同的http task。
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .all:
            return .requestPlain
            
        case .userInfo(let access_token, let uid):
            params["access_token"] = access_token
            params["uid"] = uid
        case .homeTimeline(let access_token, let since_id, let max_id):
            params["access_token"] = access_token
            params["since_id"] = since_id
            params["max_id"] = max_id
            
        case .list:
            //不需要传参数的接口走这里
            return .requestPlain
        case .compose(let access_token, let status):
            params["access_token"] = access_token
            params["status"] = status
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
}


