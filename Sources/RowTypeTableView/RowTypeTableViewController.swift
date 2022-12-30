//
//  RowTypeTableViewController.swift
//
//
//  Created by Yu-Sung Loyi Hsu on 2022/12/30.
//

import UIKit

/// The main view controller implementation that embeds a full screen table view. When using this type, you will need to initialise it with `init(rows:)`, providing the rows in `UITableViewPresentable` format.
/// To update the table view, set `rows` directly would trigger the table view to refresh, reload data by default. Write to the rowsDidChange method if you want to define custom behaviours for refresh.
public class RowTypeTableViewController: UIViewController {
    private var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    public var rowsDidChange: (UITableView) -> Void = { tableView in
        tableView.reloadData()
    }

    public var rows: [UITableViewPresentable] = [] {
        didSet {
            rowsDidChange(tableView)
        }
    }

    public convenience init(rows: [UITableViewPresentable]) {
        self.init(nibName: nil, bundle: nil)
        self.rows = rows
    }

    override public func viewDidLoad() {
        setupTableView()
    }

    private func setupTableView() {
        setupRowTypeCells()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
        ])
    }

    private func setupRowTypeCells() {
        rows
            .map(\.CellType)
            .forEach {
                tableView.register($0, forCellReuseIdentifier: "\($0.self)")
            }
    }
}

extension RowTypeTableViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return rows.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let row = rows[index]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "\(row.CellType.self)",
            for: indexPath
        ) as? UITableViewRowCell else {
            return UITableViewCell()
        }
        cell.model = row.model
        return cell
    }
}
