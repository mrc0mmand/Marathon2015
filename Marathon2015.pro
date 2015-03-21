TEMPLATE = app

CONFIG += c++11

QT += qml quick widgets

SOURCES += main.cpp \
    polygon.cpp \
    scores.cpp

RESOURCES += qml.qrc \
             data.qrc \
             sounds.qrc

EXAMPLE_IMAGE_FILES += \
    astronaut.png \
    sky.png



# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    polygon.h \
    scores.h

OTHER_FILES += AndroidManifest.xml

DISTFILES += \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/AndroidManifest.xml \
    android/gradlew.bat \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
