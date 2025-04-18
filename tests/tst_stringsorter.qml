import QtQuick 2.0
import SortFilterProxyModel 0.2
import QtQml.Models 2.2
import QtTest 1.1

Item {
    property list<StringSorter> sorters: [
        StringSorter {
            property string tag: "normal"
            property var expectedValues: ["haha", "hähä", "hehe", "héhé", "hihi", "huhu"]
            roleName: "accentRole"
            locale: Qt.locale("en_US")
        },
        StringSorter {
            property string tag: "numericMode"
            property var expectedValues: ["a1", "a20", "a30", "a99", "a100", "a1000"]
            roleName: "numericRole"
            numericMode: true
            locale: Qt.locale("en_US")
        },
        StringSorter {
            property string tag: "nonNumericMode"
            property var expectedValues: ["a1", "a100", "a1000", "a20", "a30", "a99"]
            roleName: "numericRole"
            numericMode: false
            locale: Qt.locale("en_US")
        },
        StringSorter {
            property string tag: "caseSensitive"
            property var expectedValues: ["a", "A", "b", "c", "z", "Z"]
            roleName: "caseRole"
            caseSensitivity: Qt.CaseSensitive
            locale: Qt.locale("en_US")
        },
        StringSorter {
            property string tag: "nonCaseSensitive"
            property var expectedValues: ["A", "a", "b", "c", "Z", "z"]
            roleName: "caseRole"
            caseSensitivity: Qt.CaseInsensitive
            locale: Qt.locale("en_US")
        },
        StringSorter {
            property string tag: "ignorePunctuation"
            property var expectedValues: ["aa", "a-a", "b-b", "b.c", "b-c", "bc"]
            roleName: "punctuationRole"
            ignorePunctation: true
            locale: Qt.locale("en_US")
        },
        StringSorter {
            property string tag: "doNotIgnorePunctuation"
            property var expectedValues: ["a-a", "aa", "b-b", "b-c", "b.c", "bc"]
            roleName: "punctuationRole"
            ignorePunctation: false
            locale: Qt.locale("en_US")
        }
    ]

    ListModel {
        id: dataModel
        ListElement { accentRole: "hehe"; numericRole: "a1";    caseRole: "A"; punctuationRole: "aa"}
        ListElement { accentRole: "héhé"; numericRole: "a20";   caseRole: "b"; punctuationRole: "a-a"}
        ListElement { accentRole: "huhu"; numericRole: "a99";   caseRole: "c"; punctuationRole: "b.c"}
        ListElement { accentRole: "haha"; numericRole: "a100";  caseRole: "a"; punctuationRole: "b-c"}
        ListElement { accentRole: "hihi"; numericRole: "a30";   caseRole: "Z"; punctuationRole: "bc"}
        ListElement { accentRole: "hähä"; numericRole: "a1000"; caseRole: "z"; punctuationRole: "b-b"}
    }

    SortFilterProxyModel {
        id: testModel
        sourceModel: dataModel
    }

    TestCase {
        name: "StringSorterTests"

        function test_stringSorters_data() {
            return sorters;
        }

        function test_stringSorters(sorter) {
            testModel.sorters = sorter;

            verify(testModel.count === sorter.expectedValues.length,
                   "Expected count " + sorter.expectedValues.length + ", actual count: " + testModel.count);
            let actualValues = [];
            for (var i = 0; i < testModel.count; i++) {
                actualValues.push(testModel.get(i, sorter.roleName));
            }
            compare(actualValues, sorter.expectedValues, `Locale ${sorter.locale.name}`);
        }
    }
}
