//
//  RowType.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/30.
//

/// The centre of RowTypeFramework. Conform your row type `enum` to this protocol will allow it to be presented.
public protocol RowType {
    var model: RowModelType { get }
    func didSelect()
}

public extension RowType {
    func didSelect() {}
}
