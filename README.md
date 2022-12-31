# RowTypeFramework

## RowTypeFramework Layer

Basically, `RowTypeFramework` consists of two protocols, `RowType` and `RowModelType`.
- `RowType` provides row types. Conforming to this `protocol` you will be asked to provide the model, with type conforming to `RowModelType`.

For example:

```swift
import RowTypeFramework

enum SomeRowType: RowType {
    case summary(id: UUID)
    case entry(id: UUID)

    var model: RowModelType {
        switch self {
        case let .summary(id):
            return SummaryCellModel(id: id)
        case let .entry(id):
            return EntryCellModel(id: id)
        }
    }
}
```

Selection events can be defined by a `didSelect` method, like:

```swift
enum SomeRowType: RowType {
    // ... identical setup as above
    func didSelect() {
        switch self {
        case let .entry(id):
            print("entry row with id \(id) is selected")
        case let .summary(id):
            print("summary row with id \(id) is selected")
        }
    }
}
```

## RowTypeTableView Layer

`RowTypeFramework` comes with implementations to show your `RowType` inside a `UITableView`.

- Your RowType will need to conform to the `UITableViewPresentable` protocol.

```swift
import RowTypeTableView

extension SomeRowType: UITableViewPresentable {
    var CellType: UITableViewRowCell.Type {
        switch self {
        case .summary:
            return SummaryCell.self
        case .entry:
            return EntryCell.self
        }
    }
}
```

- You will need to provide your `UITableViewCell`, which should conform to `UITableViewRowCell` protocol. You can implement how your cell model and your cell should look like within the cell as normal.

An example structure would be:

```swift
import RowTypeTableView
import UIKit

struct SummaryCellModel: RowModelType {
    let id: UUID
}

class SummaryCell: UITableViewCell, UITableViewRowCell {
    typealias RowModelType = SummaryCellModel

    var model: AnyRowModelType! {
        didSet {
            update(to: model)
        }
    }
    
    // ... UITableViewCell setup omitted
    
    func update(to model: AnyRowModelType) {
        label.text = "Summary Row: \(model.forced(to: RowModelType.self).id)"
    }
}
```

`AnyRowType` comes with two helper methods, `casted(to:)` will optional cast your model to the type you specify, while `.forced(to:)` will force unwrap the optional cast. 

### `RowTypeTableViewController`

`RowTypeTableViewController` is a base implementation which embeds a full screen `UITableView` that comes in the `RowTypeTableView` layer. You can subclass it to define your behaviour but the base usage is to just create a `RowTypeTableViewController` with rows:

```swift
func navigateToView() {
    let viewModel = SomeViewModel()
    let viewController = RowTypeTableViewController(rows: viewModel.rows)
    viewModel.rowsDidUpdate = { [weak viewController] rows in
        viewController?.rows = rows
    }
    show(viewController, sender: self)
}
```

Setting to the rows in the view controller will by default trigger the table view to reload data. You can define your custom refresh logic if you subclass `RowTypeTableViewController` and override the `rowsDidChange(_:)` method.

## Licence

[MIT](https://github.com/loyihsu/RowTypeFramework/blob/main/LICENSE)    
