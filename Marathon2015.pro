TEMPLATE = app

CONFIG += c++11

QT += qml quick widgets

SOURCES += main.cpp \
    polygon.cpp

RESOURCES += qml.qrc

EXAMPLE_IMAGE_FILES += \
    astronaut.png \
    sky.png



# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    polygon.h
