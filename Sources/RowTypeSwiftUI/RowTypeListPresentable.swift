//
//  RowTypeListPresentable.swift
//  RowTypeSwiftUI
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/31.
//

@available(iOS 13.0, *)
public protocol RowTypeListPresentable: RowType {
    var ViewType: any ViewWithModel.Type { get }
}

public struct Identified<T>: Identifiable {
    public var id: UUID
    var wrappedItem: T

    public init(id: UUID = UUID(), wrappedItem: T) {
        self.id = id
        self.wrappedItem = wrappedItem
    }
}
