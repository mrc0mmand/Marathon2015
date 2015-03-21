#ifndef SCORES_H
#define SCORES_H

#include <QObject>
#include <QAbstractListModel>

class Scores : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit Scores(QObject *parent = 0);
    ~Scores();

signals:

public slots:
};

#endif // SCORES_H
