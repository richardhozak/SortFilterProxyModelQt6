cmake_minimum_required(VERSION 3.17)

project(SortFilterProxyModel)

option(BUILD_DOCS "Build documentation" OFF)
option(BUILD_TESTING "Build tests" OFF)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(REQUIRED_QT_VERSION 6.7.0)
find_package(Qt6 ${REQUIRED_QT_VERSION} REQUIRED Core Qml)
qt_standard_project_setup(REQUIRES 6.7)

include(CTest)
include(GNUInstallDirs)

set(CMAKE_AUTOMOC ON)

add_library(
  SortFilterProxyModel OBJECT
  filters/alloffilter.cpp
  filters/alloffilter.h
  filters/anyoffilter.cpp
  filters/anyoffilter.h
  filters/expressionfilter.cpp
  filters/expressionfilter.h
  filters/filter.cpp
  filters/filter.h
  filters/filtercontainer.cpp
  filters/filtercontainer.h
  filters/filtercontainerfilter.cpp
  filters/filtercontainerfilter.h
  filters/filtersqmltypes.cpp
  filters/indexfilter.cpp
  filters/indexfilter.h
  filters/rangefilter.cpp
  filters/rangefilter.h
  filters/regexpfilter.cpp
  filters/regexpfilter.h
  filters/rolefilter.cpp
  filters/rolefilter.h
  filters/valuefilter.cpp
  filters/valuefilter.h
  proxyroles/expressionrole.cpp
  proxyroles/expressionrole.h
  proxyroles/filterrole.cpp
  proxyroles/filterrole.h
  proxyroles/joinrole.cpp
  proxyroles/joinrole.h
  proxyroles/proxyrole.cpp
  proxyroles/proxyrole.h
  proxyroles/proxyrolecontainer.cpp
  proxyroles/proxyrolecontainer.h
  proxyroles/proxyrolesqmltypes.cpp
  proxyroles/regexprole.cpp
  proxyroles/regexprole.h
  proxyroles/singlerole.cpp
  proxyroles/singlerole.h
  proxyroles/switchrole.cpp
  proxyroles/switchrole.h
  qqmlsortfilterproxymodel.cpp
  qqmlsortfilterproxymodel.h
  sorters/expressionsorter.cpp
  sorters/expressionsorter.h
  sorters/filtersorter.cpp
  sorters/filtersorter.h
  sorters/rolesorter.cpp
  sorters/rolesorter.h
  sorters/sorter.cpp
  sorters/sorter.h
  sorters/sortercontainer.cpp
  sorters/sortercontainer.h
  sorters/sortersqmltypes.cpp
  sorters/stringsorter.cpp
  sorters/stringsorter.h
)

target_include_directories(SortFilterProxyModel PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(SortFilterProxyModel PRIVATE Qt6::Core Qt6::Qml)

if((MSVC) AND (MSVC_VERSION GREATER_EQUAL 1914))
  target_compile_options(SortFilterProxyModel PUBLIC "/Zc:__cplusplus")
endif()

if(BUILD_DOCS)
  find_package(ECM REQUIRED NO_MODULE)
  set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
  include(ECMQueryQt)
  include(KDEInstallDirs)
  include(KDECompilerSettings)
  include(KDECMakeSettings)
  include(ECMGenerateQDoc)

  ecm_generate_qdoc(SortFilterProxyModel docs/sortfilterproxymodel.qdocconf)
endif()

if(BUILD_TESTING)
  add_subdirectory(tests)
endif()
