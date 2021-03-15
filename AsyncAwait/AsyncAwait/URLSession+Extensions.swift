//
//  URLSession+Extensions.swift
//  AsyncAwait
//
//  Created by Tudor Turcanu on 15.03.2021.
//

import Foundation
import _Concurrency

extension URLSession {
    func dataTask(url: URL) async -> (Data?, URLResponse?, Error?) {
        return await withUnsafeContinuation({ continuation in
            dataTask(with: url) { data, response, error in
                continuation.resume(returning:  (data, response, error))
            }.resume()
        })
    }
}

class NetworkRequest {
    @asyncHandler func getData() {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        let (data, response, error) = await URLSession.shared.dataTask(url: url)
        print(String(data: data!, encoding: .utf8))
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            print(String(data: data!, encoding: .utf8))
//        }.resume()
    }
}
