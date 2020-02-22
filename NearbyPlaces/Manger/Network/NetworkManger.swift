//
//  NetworkManger.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/21/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import Foundation

class NetworkManger {
    private let urlSession:URLSession
    init(urlSession:URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func performNetworRequest<T:Decodable>(router:Router,completion:@escaping (Result<BaseModel<T>,ApiError>)->Void)  {
        
        self.urlSession.dataTask(with: buildRequest(router)) { (data, response, error) in
            guard error == nil else{
                completion(.failure(ApiError.serviceUnAvailable))
                return
            }
            guard let data = data else{
                completion(.failure(ApiError.serviceUnAvailable))
                return
            }
            do{
                let model = try JSONDecoder().decode(BaseModel<T>.self, from: data)
                completion(.success(model))
            }catch let errorJson{
                print(errorJson)
                completion(.failure(ApiError.serviceUnAvailable))
            }
        }.resume()
    }
    
    private func buildRequest(_ router:Router)->URLRequest  {
        var component:URLComponents = URLComponents()
        component.host = router.baseUrl
        component.scheme = router.scheme
        component.path = router.path
        if let parameter = router.parameter{
            parameter.forEach{
                if component.queryItems == nil{
                    component.queryItems = []
                }
                component.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value))
            }
        }
        print(component.url ?? "")
        var urlRequest = URLRequest(url:component.url!)
        urlRequest.httpMethod = router.method.rawValue
        confiqureBody(body: router.body, request: &urlRequest)
        configureHeaders(headers: router.headers, request: &urlRequest)
        return urlRequest
    }
    private func confiqureBody(body:[String:Any]?, request:inout URLRequest)  {
        guard let bodyDic = body else {
            return
        }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: bodyDic, options: []) else {
            return
        }
        request.httpBody = httpBody
    }
    private func configureHeaders(headers:[String:String]?, request:inout URLRequest)  {
        headers?.forEach{
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
}
