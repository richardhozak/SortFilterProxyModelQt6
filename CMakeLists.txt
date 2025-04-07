cmake_minimum_required(VERSION 3.14)

project(SortFilterProxyModel)

set(CMAKE_CXX_STANDARD 17)

find_package(Qt6 REQUIRED COMPONENTS Core Qml)

option(BUILD_DOCS "Build documentation" OFF)
option(BUILD_TESTING "Build tests" OFF)

include(CTest)

set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON) # This is to find generated *.moc and *.h files in build dir

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
