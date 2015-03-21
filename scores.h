#ifndef SCORES_H
#define SCORES_H

#include <QObject>
#include <QAbstractListModel>
#include <QFile>
#include <iostream>
#include <QDebug>

class Scores : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool ready READ ready NOTIFY readyChanged)
public:
    explicit Scores(QObject *parent = 0);

    ~Scores();

    bool ready();
private:
    QString filename;
    bool m_ready;
signals:
    void readyChanged();

public slots:
    bool write(const QVariantList& content);
    QVariantList load();
};

#endif // SCORES_H
