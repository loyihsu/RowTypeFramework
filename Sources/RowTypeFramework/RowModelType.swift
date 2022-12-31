//
//  RowModelType.swift
//  RowTypeFramework
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/30.
//

/// The empty protocol to feed in any model for the row.
public protocol RowModelType {}

public struct AnyRowModelType {
    var wrappedItem: any RowModelType

    public init(wrappedItem: any RowModelType) {
        self.wrappedItem = wrappedItem
    }

    public func casted<T>(to _: T.Type) -> T? {
        return wrappedItem as? T
    }

    public func forced<T>(to type: T.Type) -> T {
        return casted(to: type)!
    }
}
