//
//  UITableView+Reusable.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

public extension UITableView {
    func register<T>(cellClass: T.Type) where T: UITableViewCell {
        self.register(cellClass, forCellReuseIdentifier: String(describing: T.self))
    }

    func registerNib<T>(cellClass: T.Type, bundle: Bundle = Bundle.main) where T: UITableViewCell {
        let nib = UINib(nibName: String(describing: T.self), bundle: bundle)
        self.register(nib, forCellReuseIdentifier: String(describing: T.self))
    }

    func registerHeaderFooterView<T>(cellClass: T.Type) where T: UITableViewHeaderFooterView {
        self.register(cellClass, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }

    func registerHeaderFooterViewNib<T>(cellClass: T.Type, bundle: Bundle = Bundle.main) where T: UITableViewHeaderFooterView {
        let nib = UINib(nibName: String(describing: T.self), bundle: bundle)
        self.register(nib, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }

    func dequeueReusableCell<T>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Cannot deuqueue cell \(String(describing: T.self))")
        }

        return cell
    }

    func dequeueReusableCell<T>(cellClass: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Cannot deuqueue cell \(String(describing: T.self))")
        }

        return cell
    }

    func dequeueReusableHeaderFooterView<T>(cellClass: T.Type) -> T {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Cannot deuqueue cell \(String(describing: T.self))")
        }

        return cell
    }
}
