//
//  UITableViewRowCell.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/30.
//

import RowTypeFramework
import UIKit

/// The common row cell protocol for all `UITableView` row cells. All row cells need to have a model defined for the row, which will be passed from row to model as is provided in the `RowType` model protocol method.
public protocol UITableViewRowCell: UITableViewCell {
    var model: AnyRowModelType! { get set }
}

public struct AnyRowModelType {
    var wrapped: any RowModelType

    public func casted<T>(to _: T.Type) -> T? {
        return wrapped as? T
    }

    public func forced<T>(to type: T.Type) -> T {
        return casted(to: type)!
    }
}
