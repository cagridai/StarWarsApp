//
//  Network.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 28.03.2023.
//

import UIKit

class Network {
    static let shared = Network()
    
    private var page: Int = 1
    
    private var lastCalledEndpointType: EndpointType?
    
    var isPaginating = false
    
    private init() {}
    
    func request<T: Decodable>(endpointType: EndpointType, decodingTo: T.Type, completion: @escaping (_ result: (Result<T, CustomError>)) -> Void) {
        isPaginating = true
        
        if var lastCalledEndpointType {
            if endpointType != lastCalledEndpointType {
                page = 1
                lastCalledEndpointType = endpointType
            }
        } else {
            lastCalledEndpointType = endpointType
        }
        
        let urlString = endpointType.endpointValue
        
        let queryItem = URLQueryItem(name: "page", value: "\(page)")
        
        guard let url = URL(string: urlString)?.appending(queryItems: [queryItem]) else {
            completion(.failure(CustomError(message: "URL is not valid!")))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            let decoder = JSONDecoder()
            
            do {
                guard let data else {
                    completion(.failure(CustomError(message: "There is no data!")))
                    return
                }
                let response = try decoder.decode(BaseResponse<T>.self, from: data)
                guard let result = response.results else {
                    completion(.failure(CustomError(message: "No result")))
                    return
                }
                
                if let nextString = response.next,
                   let nextURL = URLComponents(string: nextString),
                   let nextPage = nextURL.queryItems?.first(where: { $0.name == "page" }),
                   let value = nextPage.value,
                   let unwrappedPage = Int(value) {
                    self?.page = unwrappedPage
                } else {
                    self?.page = 0
                    completion(.failure(CustomError(message: "No more next page")))
                }
                
                completion(.success(result))
                self?.isPaginating = false
            } catch {
                completion(.failure(CustomError(message: "Data and model is not compatible!")))
                self?.isPaginating = false
            }
        }.resume()
    }
    
    func createSpinnerFooter(view: UIView) -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
}

struct CustomError: Error {
    let message: String
}


