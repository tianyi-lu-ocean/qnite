#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QSGRendererInterface>

#include <qnite.h>

int main(int argc, char *argv[]) {
  Q_INIT_RESOURCE(qnite);

  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

#ifdef Q_OS_WIN
  QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);
#endif

  QGuiApplication app(argc, argv);

  // Qt6 enable the OpenGL
  QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGL);

  QQmlApplicationEngine engine;
  engine.addImportPath(QStringLiteral("qrc:/qml"));
  engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

  return app.exec();
}
