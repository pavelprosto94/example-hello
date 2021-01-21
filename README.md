# First project for Ubuntu Touch - Hello, world!
[[статья на русском]](http://dtc1.ru/Как%20писать%20Python%20программы%20для%20Ubuntu%20Touch)

**Let's create a new project in Clickable**, enter the command in the terminal:
    
    clickable create

Choosing a Python project (option 3)

    Select Template: 3
    App Title: Hello, world!
    Description: none
    App Name [appname]: example-hello
    Namespace [yourname]: none
    Maintainer Name [Your FullName]: none
    Maintainer Email [email@domain.org]: none
    Select License: 1
    Copyright Year [2020]: 2070
    Git Tag Versioning [n]: n
    Save as Default [n]: n

Now a folder with our project **example-hello** will be created, go to it.
Projects in Ubuntu Toch are cross-platform and therefore the appropriate languages are selected for their programming.
Our project is no exception - this is a QML Pyotherside project, it can be run both on a computer and on a phone.

First, let's create the interface for application.
Find the **qml** directory in the project folder and change **Main.qml**:

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

Find the **src** directory in the project folder and change *example.py*.

    a=0
    def speak(text):
    	global a
    	a+=1
    	return text+"\n "+str(a)+" click"

In the terminal, go to our directory with the **example-hello** project and enter the command:

    clickable
	
The project will compile and run on our phone:

![ubuntu_toch_python2.jpg](http://dtc1.ru/_resources/5d84a708d8ed49ab933d4c840456b00b.jpg)
