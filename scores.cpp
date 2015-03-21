#include "scores.h"

Scores::Scores(QObject *parent) : QObject(parent)
{
    this->filename = "marathon2015.data";
}

Scores::~Scores()
{

}

bool Scores::ready()
{
    return m_ready;
}

bool Scores::write(const QVariantList& content) {
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

QVariantList Scores::load() {
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
