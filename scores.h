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
public:
    explicit Scores(QObject *parent = 0);
    ~Scores();

private:
    QString filename;
signals:

public slots:
    bool write(const QVariantList& content) {
        QFile file(this->filename);

        if(!file.open(QFile::WriteOnly | QFile::Truncate | QFile::Text))
            return false;

        QTextStream out(&file);
        QVariantList::const_iterator it;

        for(it = content.begin(); it != content.end(); it++) {
            out << it[0].toList()[0].toString() << " " << it[0].toList()[1].toInt() << "\n";
        }

        file.close();

        return true;
    }

    QVariantList load() {
        QFile file(this->filename);

        if(!file.open(QFile::ReadOnly | QFile::Text))
            return QVariantList();

        QVariantList content;
        QTextStream in(&file);
        QString line = in.readLine();

        while(!line.isNull()) {
            QStringList l = line.split(" ");
            QVariantList tmp;
            tmp.push_back(QVariant(l[0]));
            tmp.push_back(QVariant(l[1]));

            content.push_back(tmp);
            line = in.readLine();
        }

        file.close();

        return content;
    }
};

#endif // SCORES_H
