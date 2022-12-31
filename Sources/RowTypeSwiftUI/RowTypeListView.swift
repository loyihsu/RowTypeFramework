//
//  RowTypeListView.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/31.
//

import RowTypeFramework
import SwiftUI

@available(iOS 13.0, *)
public struct RowTypeListView: View {
    @Binding var rows: [Identified<any RowTypeListPresentable>]

    public init(rows: Binding<[Identified<any RowTypeListPresentable>]>) {
        _rows = rows
    }

    public var body: some View {
        List {
            ForEach(rows) { row in
                AnyViewWithModel(
                    wrappedItem: row.wrappedItem.ViewType.init(
                        model: AnyRowModelType(wrappedItem: row.wrappedItem.model)
                    )
                )
                .onTapGesture {
                    row.wrappedItem.didSelect()
                }
            }
        }
    }
}
