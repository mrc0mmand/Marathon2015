#ifndef SCORES_H
#define SCORES_H

#include <QObject>
#include <QAbstractListModel>
#include <QFile>
#include <QUrl>
#include <QDebug>
#include <QNetworkRequest>
#include <QNetworkAccessManager>
#include <QEventLoop>
#include <QNetworkReply>

class Scores : public QObject
{
    Q_OBJECT
public:
    explicit Scores(QObject *parent = 0);
    ~Scores();

private:
    QString m_filename;

signals:


public slots:
    bool write(const QString& name, int sc);
    QVariantList load();
};

#endif // SCORES_H
