//
//  SaveFiles.swift
//  BeersListDemo
//
//  Created by dqh on 10/8/23.
//

import Foundation

class SaveFiles {

    static let systemCache: URL? = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("netCache", isDirectory: true)

    class func getPath(path: String) -> URL? {
        let pathURL = handlePathUrl(path)
        let manager = FileManager.default
        var url = systemCache
        if let urlStr = systemCache?.absoluteString, manager.isExecutableFile(atPath: urlStr) == false {
            try? manager.createDirectory(at: url!, withIntermediateDirectories: true, attributes: nil)
        }
        url?.appendPathComponent(pathURL)
        return url
    }

    class func save(path: String, data: Data) {
        if let url = getPath(path: path) {
            do {
                try data.write(to: url)
                print("save success")
            } catch {
                print("save failure")
            }
        }
    }
    
    class func read(path: String) -> Data? {
        if let url = getPath(path: path), let dataRead = try? Data(contentsOf: url) {
             print("read success")
            return dataRead
        } else {
            print("read failure")
        }
        return nil
    }
    
    class func clearCache() {
        // 取出cache文件夹目录 缓存文件都在这个目录下
        if let url = systemCache {
            do {
                try? FileManager.default.removeItem(at: url)
            }
        }

    }
    
    class func handlePathUrl(_ url: String) -> String {
        return url.replacingOccurrences(of: "/", with: "")
    }
}
