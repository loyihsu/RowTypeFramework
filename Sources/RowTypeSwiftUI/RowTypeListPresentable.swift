//
//  RowTypeListPresentable.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/31.
//

import SwiftUI

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

@available(iOS 13.0, *)
public protocol ViewWithModel: View {
    var model: AnyRowModelType { get set }
    init(model: AnyRowModelType)
}

@available(iOS 13.0, *)
struct AnyViewWithModel: View {
    var wrappedItem: any ViewWithModel

    var body: some View {
        AnyView(wrappedItem.body)
    }
}
