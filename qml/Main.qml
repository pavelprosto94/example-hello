import QtQuick 2.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.3

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'example-hello.none'
    automaticOrientation: true
    width: units.gu(45)
    height: units.gu(75)
    
    Page {
        id:main
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('Hello, world!')
        }
        //create Label
        Label {
            id: label1
            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            text: 'Click me'
            verticalAlignment: Label.AlignVCenter
            horizontalAlignment: Label.AlignHCenter
            
            //create an area for handling mouse events
            MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            
            onPressed: {
                //connect and execute the speak function
                python.call('example.speak', ['Hello World!'], function ( result ) {
                label1.text=result;
                });
            }
            }
        }
    }

//declare a variable to import a Python module
    Python {
        id: python
        //connect example.py
        Component.onCompleted: {
        addImportPath(Qt.resolvedUrl('../src/'));
        importModule_sync("example")
        } 
        onError: {
            console.log('python error: ' + traceback);
        }          
    }
}
