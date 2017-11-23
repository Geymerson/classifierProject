/**
    IA2 Project: This application uses
    the OneR machine learning algorithm to
    identify male and female gender by voice

    @author: Geymerson Ramos
    email: geymerson@ic.ufal.br
    Federal University of Alagoas

    Last modified: November, 20, 2017
**/

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "./header/mediator.h"

int main(int argc, char *argv[]) {

    QGuiApplication app(argc, argv);

    qmlRegisterType<Mediator>("ia2.project", 1, 0, "Mediator");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
