//
//  UITableViewPresentable.swift
//  RowTypeTableView
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/30.
//

import RowTypeFramework
import UIKit

/// The centre of UITableView abstraction using RowTypeFramework. Providing your `CellType` will allow the framework to automatically map your `RowType` to the specified `UITableViewRowCell` type.
public protocol UITableViewPresentable: RowType {
    var CellType: UITableViewRowCell.Type { get }
}
