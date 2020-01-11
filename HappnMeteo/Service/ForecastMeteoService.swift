//
//  ForecastMeteoService.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import Foundation
import os.log

protocol ForecastMeteoService {
    func fetchForecastMeteo(
        for city: String,
        apiKey: String,
        useCache: Bool,
        calendar: Calendar,
        completion: @escaping (Result<[ForeCastMeteo], Swift.Error>) -> Void)
}

final class ForecastMeteoServiceImpl: ForecastMeteoService {

    let api = API()

    func fetchForecastMeteo(
        for city: String,
        apiKey: String,
        useCache: Bool,
        calendar: Calendar,
        completion: @escaping (Result<[ForeCastMeteo], Error>) -> Void) {

        if let data = Preferences.cacheMeteo {
            do {
                let values = try JSONDecoder().decode([ForeCastMeteo].self, from: data)

                // Check if we have a date corresponding to today. If yes, returns cache else prefer fetch new content
                let hasTodayDate = !values
                    .map({$0.dt.dateTimestamp})
                    .filter({calendar.isDateInToday($0)})
                    .isEmpty
                if hasTodayDate {
                    completion(.success(values))
                    os_log("Cache used")
                    return
                }
            } catch {
                completion(.failure(APIError.dataCorrupted))
                os_log("Cache corrupted")
            }

            os_log("Cache not used")
        }

        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = Constants.forcastPath
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "APPID", value: apiKey),
            URLQueryItem(name: "mode", value: "json")
        ]

        guard let url = components.url else {
            completion(.failure(APIError.badURL))
            return
        }

        let responseResult = ResponseRequest<ForeCastMeteoList> { (result) in
            switch result {
            case .success(let value):
                Preferences.cacheMeteo = try? JSONEncoder().encode(value.list)
                completion(.success(value.list))
            case .failure(let error):
                completion(.failure(error))
            }
        }

        api.request(url: url, result: responseResult)?.resume()
    }
}

struct APIIcon {

    static func buildURL(with icon: String) -> URL? {
        let iconName = "/" + icon + "@2x.png"
        return URL(string: "\(Constants.schemeIcon)://\(Constants.hostIcon)\(Constants.pathIcon)\(iconName)")
    }
}
