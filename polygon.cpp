#include "polygon.h"

Polygon::Polygon(QQuickPaintedItem *parent) :
        QQuickPaintedItem(parent) {
    // Important, otherwise the paint method is never called
    setFlag(QQuickItem::ItemHasContents, true);
    setFlag(QQuickItem::ItemClipsChildrenToShape, false);
    setClip(false);

    updateSize();
    update();
}

void Polygon::paint(QPainter *painter) {
    QPen pen(m_borderColor, m_penWidth);
    painter->setPen(pen);
    painter->setBrush(m_fillColor);

    if(smooth() == true) {
        painter->setRenderHint(QPainter::Antialiasing, true);
    }

    if (m_displayWidth == 0 || m_displayHeight == 0) {
        painter->translate(-x() + m_penWidth / 2.0, -y() + m_penWidth / 2.0);
    }
    else {
        painter->translate(m_polygon.boundingRect().topLeft() * (-m_factor) + QPointF(m_penWidth / 2, m_penWidth / 2));
    }


    QPolygonF pCopy;
    for (QPointF p : m_polygon) {
        pCopy.append(p * m_factor);
    }
    painter->drawPolygon(pCopy);
}

QColor Polygon::fillColor() const {
    return m_fillColor;
}

QColor Polygon::borderColor() const {
    return m_borderColor;
}

qreal Polygon::borderWidth() const {
    return m_penWidth;
}

QVariantList Polygon::vertices() const {
    QVariantList vl;
    for (QPointF p : m_polygon)
        vl.append(QVariant::fromValue(p));
    return vl;
}

qreal Polygon::factor() const {
    return m_factor;
}

qreal Polygon::displayHeight() const {
    return m_displayHeight;
}

qreal Polygon::displayWidth() const {
    return m_displayWidth;
}

void Polygon::setBorderColor(const QColor &color) {
    if (m_borderColor != color) {
        m_borderColor = color;
        emit borderColorChanged();
        update();
    }
}

void Polygon::setFillColor(const QColor &color) {
    if (m_fillColor != color) {
        m_fillColor = color;
        emit fillColorChanged();
        update();
    }
}

void Polygon::setBorderWidth(qreal newWidth) {
    if (m_penWidth != newWidth) {
        m_penWidth = newWidth;
        updateSize();
        emit borderWidthChanged();
        update();
    }
}

void Polygon::setVertices(QVariantList vl) {
    m_polygon.clear();
    for (QVariant &v : vl) {
        m_polygon.append(v.toPointF());
    }
    updateSize();
    emit verticesChanged();
    update();
}

void Polygon::setFactor(qreal f) {
    if (f != m_factor) {
        m_factor = f;
        updateSize();
        emit factorChanged();
    }
}

void Polygon::setDisplayWidth(qreal w) {
    if (w != m_displayWidth) {
        m_displayWidth = w;
        updateSize();
        emit displayWidthChanged();
        update();
    }
}

void Polygon::setDisplayHeight(qreal h) {
    if (h != m_displayHeight) {
        m_displayHeight = h;
        updateSize();
        emit displayHeightChanged();
        update();
    }
}

void Polygon::setPolygon(QPolygonF p) {
    m_polygon = p;
    m_handSet = true;
    updateSize();
    emit verticesChanged();
}

void Polygon::updateSize() {
    qreal left = HUGE_VAL;
    qreal right = -HUGE_VAL;
    qreal top = HUGE_VAL;
    qreal bottom = -HUGE_VAL;
    for (QPointF &p : m_polygon) {
        if (p.x() < left)
            left = p.x();
        if (p.x() > right)
             right = p.x();
        if (p.y() < top)
             top = p.y();
        if (p.y() > bottom)
             bottom = p.y();
    }

    if (m_displayWidth > 0 && m_displayHeight > 0) {
        setX(0);
        setY(0);
        m_factor = m_displayWidth / (right - left) < m_displayHeight / (bottom - top) ? m_displayWidth / (right - left): m_displayHeight / (bottom - top);
        setWidth(m_factor * (right - left) + m_penWidth * 1.5);
        setHeight(m_factor * (bottom - top) + m_penWidth * 1.5);
    }
    else {
        setX((left) * m_factor - m_penWidth / 2);
        setY((top) * m_factor - m_penWidth / 2);
        setWidth((right - left) * m_factor +  m_penWidth * 1.5);
        setHeight((bottom - top) * m_factor + m_penWidth * 1.5);
    }
}
