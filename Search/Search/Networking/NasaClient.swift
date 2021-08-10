//
//  NasaClient.swift
//  Search
//
//  Created by Bella Wei on 8/4/21.
//

import Foundation

protocol SessionDataTaskMaker {
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: SessionDataTaskMaker {}

class NasaClient {
    let session: SessionDataTaskMaker
    let baseURL: URL
    static let shared = NasaClient(session: URLSession.shared, baseURL: URL(string: EndPoint.base)!)

    init(session: SessionDataTaskMaker, baseURL: URL) {
        self.session = session
        self.baseURL = baseURL
    }

    func taskForGETRequest<ResponseType: Decodable>(url: URL, response _: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        let task = session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }

            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }

    func fetchResults(query: String, completion: @escaping (APIResponse?, Error?) -> Void) {
        taskForGETRequest(url: EndPoint.querySearch(query).url, response: APIResponse.self) {
            response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
