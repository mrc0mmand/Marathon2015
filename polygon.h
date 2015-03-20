#ifndef POLYGON_H
#define POLYGON_H

#include <QQuickItem>
#include <QQuickPaintedItem>
#include <QPainter>

class Polygon : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QColor fillColor READ fillColor WRITE setFillColor NOTIFY fillColorChanged)
    Q_PROPERTY(QColor borderColor READ borderColor WRITE setBorderColor NOTIFY borderColorChanged)
    Q_PROPERTY(qreal borderWidth READ borderWidth WRITE setBorderWidth NOTIFY borderWidthChanged)
    Q_PROPERTY(QVariantList vertices READ vertices WRITE setVertices NOTIFY verticesChanged)
    Q_PROPERTY(qreal factor READ factor WRITE setFactor NOTIFY factorChanged)
    Q_PROPERTY(qreal displayWidth READ displayWidth WRITE setDisplayWidth NOTIFY displayWidthChanged)
    Q_PROPERTY(qreal displayHeight READ displayHeight WRITE setDisplayHeight NOTIFY displayHeightChanged)

public:
    Polygon(QQuickPaintedItem *parent = 0);

    void paint(QPainter *painter);

    QColor fillColor() const;
    QColor borderColor() const;
    qreal borderWidth() const;
    QVariantList vertices() const;
    qreal factor() const;
    qreal displayHeight() const;
    qreal displayWidth() const;

    void setFillColor(const QColor &color);
    void setBorderColor(const QColor &color);
    void setBorderWidth(qreal newWidth);
    void setVertices(QVariantList v);
    void setFactor(qreal f);
    void setDisplayWidth(qreal w);
    void setDisplayHeight(qreal h);

    void setPolygon(QPolygonF p);
signals:
    void fillColorChanged();
    void borderColorChanged();
    void borderWidthChanged();
    void verticesChanged();
    void factorChanged();
    void displayWidthChanged();
    void displayHeightChanged();

protected:
    void updateSize();

protected:
    QColor m_fillColor { Qt::transparent };
    QColor m_borderColor { Qt::black };
    qreal m_penWidth { 5 };
    QPolygonF m_polygon { };
    qreal m_factor { 1 };
    bool m_handSet { false };
    qreal m_displayWidth { -1 };
    qreal m_displayHeight { -1 };
    qreal m_computedWidth { 0 };
    qreal m_computedHeight { 0 };
    qreal m_computedFactor { -1 };
};

QML_DECLARE_TYPE(Polygon)

#endif // POLYGON_H
