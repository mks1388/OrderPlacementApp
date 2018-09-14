//
//  ProductClient.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 14/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation

struct ProductClient {
    private struct Constants {
        static let productUrl = "http://demo1618610.mockable.io/products"
    }
    
    static let shared = ProductClient()
    
    private var session:URLSession!
    
    private init() {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func getAllProductList(_ completion: @escaping ((Data?) -> Void)) {
        guard let url = URL(string: Constants.productUrl) else {
            completion(nil)
            return
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }
        task.resume()
    }
}
