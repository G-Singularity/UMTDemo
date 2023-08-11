//
//  HttpTool.swift
//  BeersListDemo
//
//  Created by dqh on 8/8/23.
//

import Alamofire
import Moya
//import SwiftyJSON
//import SVProgressHUD

public class HttpsTool {
    
    /// 使用moya的请求封装（直接转为目标model，不过model的设计要多一层）
    ///
    /// - Parameters:
    ///   - target: TargetType里的枚举值
    ///   - model: model类型
    ///   - cache: 需要单独处理缓存的数据时使用
    ///   - success: 成功的回调
    ///   - error: 连接服务器成功但是数据获取失败
    ///   - failure: 连接服务器失败
    public class func loadData<T: TargetType, D: Decodable>(target: T, model: D.Type?, cache: ((D?) -> Void)? = nil, success: @escaping((D?) -> Void), failure: ((Int?, String) -> Void)? ) {
        let provider = MoyaProvider<T>(plugins: [
            RequestHandlingPlugin(),
            networkLoggerPlugin
        ])
        ProgressHUD.show()
//        //如果需要读取缓存，则优先读取缓存内容
//        if let cache = cache, let data = SaveFiles.read(path: target.path) {
//            let model = try? JSONDecoder().decode(D.self, from: data)
//            cache(model)
//        } else {
//            //读取缓存速度较快，无需显示hud；仅从网络加载数据时，显示hud。
//            //ProgressHUD.show()
//        }
        
        provider.request(target) { result in
            ProgressHUD.hide()
            switch result {
            case let .success(response):
                do {
                    let model = try JSONDecoder().decode(D.self, from: response.data)
                    success(model)
                    
                    //SaveFiles.save(path: target.path, data: response.data)
                } catch {
                    print(error)
                    failureHandle(failure: nil, stateCode: 0, message: "Decoder failure")
                }
                
            case let .failure(error):
                let statusCode = error.response?.statusCode ?? 0
                let errorCode = "request failure, error code:" + String(statusCode)
                failureHandle(failure: failure, stateCode: statusCode, message: error.errorDescription ?? errorCode)
            }
        }
        
        //错误处理 - 弹出错误信息
        func failureHandle(failure: ((Int?, String) ->Void)? , stateCode: Int?, message: String) {
            Alert.show(type: .error, text: message)
            failure?(stateCode ,message)
        }
    }
    
    ///打印日志
    static let networkLoggerPlugin = NetworkLoggerPlugin(verbose: true, cURL: true, requestDataFormatter: { data -> String in
        return String(data: data, encoding: .utf8) ?? ""
    }) { data -> (Data) in
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data
        }
    }

}
