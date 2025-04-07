cmake_minimum_required(VERSION 3.14)

enable_testing()

project(SortFilterProxyModel)

set(CMAKE_CXX_STANDARD 17)

find_package(Qt6 REQUIRED COMPONENTS Core Qml)

option(BUILD_DOCS "Build documentation" OFF)

set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON) # This is to find generated *.moc and *.h files in build dir

add_library(
  SortFilterProxyModel OBJECT
  qqmlsortfilterproxymodel.cpp
  qvariantlessthan.cpp
  filters/filter.cpp
  filters/filtercontainer.cpp
  filters/rolefilter.cpp
  filters/valuefilter.cpp
  filters/indexfilter.cpp
  filters/regexpfilter.cpp
  filters/rangefilter.cpp
  filters/expressionfilter.cpp
  filters/filtercontainerfilter.cpp
  filters/anyoffilter.cpp
  filters/alloffilter.cpp
  filters/filtersqmltypes.cpp
  sorters/sorter.cpp
  sorters/sortercontainer.cpp
  sorters/rolesorter.cpp
  sorters/stringsorter.cpp
  sorters/expressionsorter.cpp
  sorters/sortersqmltypes.cpp
  proxyroles/proxyrole.cpp
  proxyroles/proxyrolecontainer.cpp
  proxyroles/joinrole.cpp
  proxyroles/switchrole.cpp
  proxyroles/expressionrole.cpp
  proxyroles/proxyrolesqmltypes.cpp
  proxyroles/singlerole.cpp
  proxyroles/regexprole.cpp
  sorters/filtersorter.cpp
  proxyroles/filterrole.cpp
  utils/utils.cpp
  utils/utils.h
)

target_link_libraries(SortFilterProxyModel PRIVATE Qt6::Core Qt6::Qml)

if((MSVC) AND (MSVC_VERSION GREATER_EQUAL 1914))
  target_compile_options(SortFilterProxyModel PUBLIC "/Zc:__cplusplus")
endif()

target_include_directories(
  SortFilterProxyModel
  PUBLIC ${CMAKE_CURRENT_LIST_DIR} $<TARGET_PROPERTY:Qt6::Core,INTERFACE_INCLUDE_DIRECTORIES>
         $<TARGET_PROPERTY:Qt6::Qml,INTERFACE_INCLUDE_DIRECTORIES>
)

if(BUILD_DOCS)
  find_package(ECM REQUIRED NO_MODULE)
  set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
  include(ECMQueryQt)
  include(KDEInstallDirs)
  include(KDECompilerSettings)
  include(KDECMakeSettings)
  include(ECMGenerateQDoc)

  ecm_generate_qdoc(SortFilterProxyModel sortfilterproxymodel.qdocconf)
endif()

if(BUILD_TESTING)
  add_subdirectory(tests)
endif()
