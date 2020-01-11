//
//  API.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import Foundation

enum APIError: Error {
    case unknown
    case badURL
    case dataCorrupted
}

final class API {

    let queue: DispatchQueue
    let session: URLSession
    let decoder: JSONDecoder

    init(queue: DispatchQueue = DispatchQueue.main, session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.queue = queue
        self.session = session
        self.decoder = decoder
    }

    @discardableResult
    public func request<Response: Decodable>(url: URL, result: ResponseRequest<Response>) -> URLSessionDataTask? {

        let task = session.dataTask(with: url) { [mainQueue = self.queue, weak self] (data, response, networkError) in
            if let d = data, let self = self {
                do {
                    let r = try self.decoder.decode(Response.self, from: d)
                    mainQueue.async {
                        result.completion(Result.success(r))
                    }
                } catch {
                    mainQueue.async {
                        result.completion(Result.failure(error))
                    }
                }

            } else if let err = networkError {
                mainQueue.async {
                    result.completion(Result.failure(err))
                }

            } else {
                mainQueue.async {
                    result.completion(Result.failure(APIError.unknown))
                }
            }
        }

        return task
    }
}

final class ResponseRequest<T: Decodable> {

    typealias Handler = (Result<T, Swift.Error>) -> Void

    var completion: Handler

    init(handler: @escaping Handler) {
        self.completion = handler
    }
}
