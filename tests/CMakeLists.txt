project (GUIQMLScreenTest CXX)

find_package(Qt6 REQUIRED COMPONENTS
    Core
    Qml
    Quick
    QuickTest
)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

add_executable(SortFilterProxyModelTest
    tst_sortfilterproxymodel.cpp
    indexsorter.h
    testroles.h
    indexsorter.cpp
    testroles.cpp
    tst_rangefilter.qml
    tst_indexfilter.qml
    tst_sourceroles.qml
    tst_sorters.qml
    tst_helpers.qml
    tst_builtins.qml
    tst_rolesorter.qml
    tst_stringsorter.qml
    tst_proxyroles.qml
    tst_joinrole.qml
    tst_switchrole.qml
    tst_expressionrole.qml
    tst_filtercontainerattached.qml
    tst_filtercontainers.qml
    tst_regexprole.qml
    tst_filtersorter.qml
    tst_filterrole.qml
    tst_delayed.qml
    tst_sortercontainerattached.qml
)

target_link_libraries(SortFilterProxyModelTest
    PRIVATE
        Qt6::Core
        Qt6::Qml
        Qt6::Quick
        Qt6::QuickTest
        SortFilterProxyModel
)

target_compile_definitions(SortFilterProxyModelTest PUBLIC QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}")

add_test(NAME SortFilterProxyModelTest COMMAND SortFilterProxyModelTest -platform offscreen)
