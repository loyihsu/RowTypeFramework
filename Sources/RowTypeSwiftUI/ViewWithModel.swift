//
//  ViewWithModel.swift
//  RowTypeSwiftUI
//
//  Created by Yu-Sung Loyi Hsu on 2023/1/1.
//

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
