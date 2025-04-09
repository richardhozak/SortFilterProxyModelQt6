SortFilterProxyModel
====================

SortFilterProxyModel is a Qt6 implementation of `QSortFilterProxyModel` conveniently exposed for QML.

Documentation: https://richardhozak.github.io/SortFilterProxyModelQt6/

This is a fork that combines the changes from
- [MenloSystems/SortFilterProxyModel](https://github.com/MenloSystems/SortFilterProxyModel)
- [valaczka/SortFilterProxyModel](https://github.com/valaczka/SortFilterProxyModel)
- And also adds:
  - Fixed QML tests for testing different sorters/filters
  - Added GitHub Actions
  - Updated documentation to point to Qt6
  - Automatic generation of [html docs](https://richardhozak.github.io/SortFilterProxyModelQt6) from CMake
  - Running tests with CTest (CMake) or QtCreator

In order to make the maintenance easier going forward the Qt5 support is removed and only Qt6 is supported (if you want to support Qt5, feel free to open a PR with necessary changes).

Install
-------
##### With git submodule:
1. `git submodule add https://github.com/richardhozak/SortFilterProxyModelQt6`
2. add `add_directory(SortFilterProxyModelQt6)` to your CMakeLists.txt
3. add `target_link_libraries(YourProject PRIVATE SortFilterProxyModelQt6)` to your CMakeLists.txt

##### With [CPM.cmake](https://github.com/cpm-cmake/CPM.cmake):
1. Follow the instructions at https://github.com/cpm-cmake/CPM.cmake to add CPM to your project
2. Add `CPMAddPackage("gh:richardhozak/SortFilterProxyModelQt6")` to your CMakeLists.txt
3. add `target_link_libraries(YourProject PRIVATE SortFilterProxyModelQt6)` to your CMakeLists.txt

You can then use this library by adding `import SortFilterProxyModel 0.2` in your QML files

Sample Usage
------------

- You can do simple filtering and sorting with SortFilterProxyModel:
```qml
import QtQuick 2.2
import QtQuick.Controls 1.2
import SortFilterProxyModel 0.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480

    ListModel {
        id: personModel
        ListElement {
            firstName: "Erwan"
            lastName: "Castex"
            favorite: true
        }
        // ...
    }

    TextField {
        id: textField
        anchors { top: parent.top; left: parent.left; right: parent.right }
        height: implicitHeight
    }

    SortFilterProxyModel {
        id: personProxyModel
        sourceModel: personModel
        filters: RegExpFilter {
            roleName: "lastName"
            pattern: textField.text
            caseSensitivity: Qt.CaseInsensitive
        }
        sorters: StringSorter { roleName: "firstName" }
    }

    ListView {
        anchors { top: textField.bottom; bottom: parent.bottom; left: parent.left; right: parent.right }
        model: personProxyModel
        delegate: Text { text: model.firstName + " " + model.lastName}
    }
}
```
Here the `ListView` will only show elements that contains the content of the `TextField` in their `lastName` role.

- But you can also achieve more complex filtering or sorting with multiple `filters` and `sorters`:
```qml
    SortFilterProxyModel {
        id: personProxyModel
        sourceModel: personModel
        filters: [
            ValueFilter {
                enabled: onlyShowFavoritesCheckbox.checked
                roleName: "favorite"
                value: true
            },
            AnyOf {
                RegExpFilter {
                    roleName: "lastName"
                    pattern: textField.text
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "firstName"
                    pattern: textField.text
                    caseSensitivity: Qt.CaseInsensitive
                }
            }
        ]
        sorters: [
            RoleSorter { roleName: "favorite"; sortOrder: Qt.DescendingOrder },
            StringSorter { roleName: "firstName" },
            StringSorter { roleName: "lastName" }
        ]
    }

    CheckBox {
        id:onlyShowFavoritesCheckbox
    }
```
This will show in the corresponding `ListView` only the elements where the `firstName` or the `lastName` match the text entered in the `textField`, and if the `onlyShowFavoritesCheckbox` is checked it will aditionnally filter the elements where `favorite` is `true`.
The favorited elements will be shown first and all the elements are sorted by `firstName` and then `lastName`.

License
-------
This library is licensed under the MIT License.

Documentation
-------------
This component is a subclass of [`QSortFilterProxyModel`](http://doc.qt.io/qt-6/qsortfilterproxymodel.html), to use it, you need to set the `sourceModel` property to a [`QAbstractItemModel*`](http://doc.qt.io/qt-6/qabstractitemmodel.html) with correct role names.
This means you can use it with custom c++ models or `ListModel`, but not with JavaScript models like arrays, integers or object instances.

The complete documentation reference is available here: https://richardhozak.github.io/SortFilterProxyModelQt6/

Contributing
------------
Don't hesitate to open an issue about a suggestion, a bug, a lack of clarity in the documentation, etc.

Pull requests are also welcome, if it's a important change you should open an issue first though.
