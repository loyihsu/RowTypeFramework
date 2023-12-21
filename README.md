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

`RowTypeTableViewController` is a base implementation which embeds a full screen `UITableView` that comes in the `RowTypeTableView` layer. You can subclass it to define your behaviour.

```swift
final class SomeViewController: RowTypeTableViewController {
    private let viewModel = SomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rows = viewModel.rows
        viewModel.rowsDidUpdate = { [weak self] in
            self?.rows = $0
        }
    }
}
```

Setting to the rows in the view controller will by default trigger the table view to reload data. You can define your custom refresh logic if you subclass `RowTypeTableViewController` and override the `rowsDidChange(_:)` method.

## RowTypeSwiftUI layer

RowTypeFramework also comes with a base implementation for SwiftUI.

The core (`RowType`) is shared across the framework, to use SwiftUI implementation, you would need to conform it to the `RowTypeListPresentable` protocol.

```swift
import RowTypeSwiftUI

extension SomeRowType: RowTypeListPresentable {
    var ViewType: any ViewWithModel.Type {
        switch self {
        case .summary:
            return SummaryView.self
        case .entry:
            return EntryView.self
        }
    }
}
```

Each of your view will need to conform to the `ViewWithModel` protocol, a base implementation can be like:

```swift
import RowTypeSwiftUI

// SummaryCellModel renamed to SummaryViewModel here, thus you will need to register this type name as model in `RowType`.
struct SummaryViewModel: RowModelType {
    let id: UUID
}

struct SummaryView: ViewWithModel {
    typealias ViewModelType = SummaryViewModel
    var model: AnyRowModelType

    init(model: AnyRowModelType) {
        self.model = model
    }

    var body: some View {
        VStack {
            Text("Summary Cell")
            Text(model.forced(to: ViewModelType.self).id.uuidString)
        }
        .listRowSeparator(.hidden)
    }
}

```

The base idea is the same as the UITableView implementation.

Finally, to present it onto the screen, pass the row types as a `Identified` wrapped binding to `RowTypeListView`. 

```swift
struct ContentView: View {
    @State var rows: [Identified<any RowTypeListPresentable>] = [
        SomeRowType.summary(id: UUID()),
        SomeRowType.entry(id: UUID()),
        SomeRowType.entry(id: UUID()),
        SomeRowType.entry(id: UUID()),
        SomeRowType.entry(id: UUID()),
    ].map {
        Identified(wrappedItem: $0)
    }

    var body: some View {
        RowTypeListView(rows: $rows)
            .listStyle(.plain)
    }
```

## Licence

[MIT](https://github.com/loyihsu/RowTypeFramework/blob/main/LICENSE)    
