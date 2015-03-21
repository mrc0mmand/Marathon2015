#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "polygon.h"
#include "scores.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    qmlRegisterType<Polygon>("WhateverDude", 1, 0, "Polygon");

    Scores scores;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("scoresSaver", &scores);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    return app.exec();
}
