#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include "drawline.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<DrawLine>("com.llliuyx.drawline", 1, 0, "DrawLine");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

