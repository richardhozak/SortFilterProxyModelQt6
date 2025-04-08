project(SortFilterProxyModelTest CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Qml Quick QuickTest)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

add_executable(
  SortFilterProxyModelTest indexsorter.cpp indexsorter.h qmltest.cpp testroles.cpp testroles.h
)

macro(qml_add_tests)
  foreach(test ${ARGV})
    target_sources(SortFilterProxyModelTest PUBLIC ${test})
    add_test(
      NAME ${test}
      COMMAND SortFilterProxyModelTest -platform offscreen -input ${test}
      WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )
  endforeach()
endmacro()

qml_add_tests(
  tst_builtins.qml
  tst_delayed.qml
  tst_expressionrole.qml
  tst_filtercontainerattached.qml
  tst_filtercontainers.qml
  tst_filterrole.qml
  tst_filtersorter.qml
  tst_helpers.qml
  tst_indexfilter.qml
  tst_joinrole.qml
  tst_proxyroles.qml
  tst_rangefilter.qml
  tst_regexprole.qml
  tst_rolesorter.qml
  tst_sortercontainerattached.qml
  tst_sorters.qml
  tst_sourceroles.qml
  tst_stringsorter.qml
  tst_switchrole.qml
)

target_link_libraries(
  SortFilterProxyModelTest PRIVATE Qt6::Core Qt6::Qml Qt6::Quick Qt6::QuickTest
                                   SortFilterProxyModel
)

target_compile_definitions(
  SortFilterProxyModelTest PUBLIC QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}"
)
