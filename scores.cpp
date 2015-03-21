#include "scores.h"

Scores::Scores(QObject *parent) : QObject(parent)
{
    this->m_filename = "marathon2015.data";

}

Scores::~Scores()
{

}

bool Scores::write(const QString& name, int sc)
{
   /* QFile file(this->m_filename);

    if(!file.open(QFile::WriteOnly | QFile::Truncate | QFile::Text))
        return false;

    QTextStream out(&file);
    QVariantList::const_iterator it;

    for(it = content.begin(); it != content.end(); it++) {
        out << it[0].toList()[0].toString() << " " << it[0].toList()[1].toInt() << "\n";
    }

    file.close();

    return true;*/
    qDebug() << "Test: " << sc;
    QNetworkAccessManager NAMan;
    QUrl url(QString("http://blaskovic.sk/mcfit/?nick=%1&score=%2").arg(name).arg(sc));
    qDebug() << url;
    QNetworkRequest request(url);
    QNetworkReply *reply = NAMan.get(request);
    QEventLoop eventLoop;
    QObject::connect(reply, SIGNAL(finished()), &eventLoop, SLOT(quit()));
    eventLoop.exec();

    return true;
}

QVariantList Scores::load()
{
    /*QFile file(this->m_filename);

    if(!file.open(QFile::ReadOnly | QFile::Text))
        return QVariantList();*/
    //QTextStream in(&file);

    QNetworkAccessManager NAMan;
    QUrl url("http://blaskovic.sk/mcfit/");
    QNetworkRequest request(url);
    QNetworkReply *reply = NAMan.get(request);
    QEventLoop eventLoop;
    QObject::connect(reply, SIGNAL(finished()), &eventLoop, SLOT(quit()));
    eventLoop.exec();
    qDebug() << "Got content";
    QVariantList content;

    QString r(reply->readAll());
    QStringList list = r.split("\n");

   // qDebug() << streamOut;

    for(int i = 0; i < list.length(); i++) {
        QStringList l = list[i].split(" ");
        qDebug() << l;
        QVariantList tmp;
        if(l[0].length() > 0 && l[1].length() > 0) {
            tmp.push_back(QVariant(l[0]));
            tmp.push_back(QVariant(l[1]));

            content.push_back(tmp);
        }
    }
  /*  while(!line.isNull()) {
        QStringList l = line.split(" ");
        qDebug() << l;
        QVariantList tmp;
        tmp.push_back(QVariant(l[0]));
        tmp.push_back(QVariant(l[1]));

        content.push_back(tmp);
        line = reply->readLine();
    }*/

    //file.close();

    return content;
}
