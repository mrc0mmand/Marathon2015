#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "polygon.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    qmlRegisterType<Polygon>("WhateverDude", 1, 0, "Polygon");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
