//
//  HomeViewModel.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func showDetail(meteoDay: ForeCastMeteo)
}

protocol HomeViewModel: AnyObject {
    var delegate: HomeViewModelDelegate? { get set }
    var items: [MeteoDayItem] { get }
    var refresh: ( () -> Void )? { get set }

    func didSelect(item: MeteoDayItem)
    func filterUniqDayWeek(with items: [ForeCastMeteo]) -> [ForeCastMeteo]
}

final class HomeViewModelImpl: HomeViewModel {
    weak var delegate: HomeViewModelDelegate?

    var refresh: (() -> Void)?

    var items: [MeteoDayItem] = [] {
        didSet {
            refresh?()
        }
    }

    private var serialQueue = DispatchQueue(label: "com.hbmedia.happnmeteo.items")

    private let service: ForecastMeteoService

    private var lastFetchedItems: [ForeCastMeteo] = []

    init(service: ForecastMeteoService) {
        self.service = service

        service.fetchForecastMeteo(
        for: Preferences.city,
        apiKey: Constants.apiKey,
        useCache: true,
        calendar: Calendar.current) { [weak self] result in
            guard let self = self else { return }
            switch result {

            case .success(let value):
                self.lastFetchedItems = value
                self.items = self.filterUniqDayWeek(with: value)
                .map({
                    MeteoDayItem(
                        dt: $0.dt,
                        day: $0.dayWeek,
                        meanTemperature: Int($0.main.temp),
                        iconPathURL: $0.weather.first?.icon)
                })
            case .failure(_):
                break
            }

            self.refresh?()
        }
    }

    func didSelect(item: MeteoDayItem) {
        guard let meteo = lastFetchedItems.first(where: {$0.dt == item.dt}) else { return }
        delegate?.showDetail(meteoDay: meteo)
    }

    func filterUniqDayWeek(with items: [ForeCastMeteo]) -> [ForeCastMeteo] {
        var array: [ForeCastMeteo] = []
        items.forEach { (meteo) in
            if array.contains(where: {$0.dayWeek == meteo.dayWeek}) {
                return
            } else {
                array.append(meteo)
            }
        }

        return array
    }

}
