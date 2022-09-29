//
//  ViewModel.swift
//  TetGAPSI
//
//  Created by Sebastian TC on 28/09/22.
//

import Combine
import SwiftUI

class ViewModel: ObservableObject {
    private var task: URLSessionDataTask?
    @Published var suggestedSearches: [String]?
    @Published var models: ResponseModel?
    
    func fetchModels(search: String, page: Int) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "00672285.us-south.apigw.appdomain.cloud"
        components.path = "/demo-gapsi/search"
        components.queryItems = [
            URLQueryItem(name: "query", value: search),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        guard let url = components.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("adb8204d-d574-4394-8c1a-53226a40876e", forHTTPHeaderField: "X-IBM-Client-Id")
        
        task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            let decoder = JSONDecoder()

            do {
                let decoded = try decoder.decode(ResponseModel.self, from: data ?? Data())
                DispatchQueue.main.async() {
                    self.models = decoded
                }
            } catch {
                print("Failed to decode JSON")
            }

        })
        task?.resume()
    }
    
    func cancelTask() {
        task?.cancel()
    }
    
    func saveSearch(searchText: String) {
        let defaults = UserDefaults.standard
        var array: [String] = []
        if let tmp = defaults.array(forKey: "searches") as? [String] {
            array = tmp
        }
        array.append(searchText)
        defaults.set(array, forKey: "searches")
    }
    
    func readSearches() -> [String] {
        let defaults = UserDefaults.standard
        var array: [String] = []
        if let tmp = defaults.array(forKey: "searches") as? [String] {
            array = tmp
        }
        
        return array
    }
}


