#ifndef DRAWLINE_H
#define DRAWLINE_H

#include <QQuickPaintedItem>
#include <QPainter>
#include <QLineF>
#include <QPen>
#include <QPointF>

class DrawLine : public QQuickPaintedItem
{
    Q_OBJECT
public:
    DrawLine();
    void paint(QPainter *painter);
    Q_INVOKABLE void setDrawLineP1(const QPointF& p1);
    Q_INVOKABLE void setDrawLineP2(const QPointF& p2);
    Q_INVOKABLE void addLine(const QPointF &p2);
    Q_INVOKABLE void finishedDrawLine();
    Q_INVOKABLE QPointF getP1();
    Q_INVOKABLE bool hasP1();
    Q_INVOKABLE void clearLines();

private:
    QLineF line;
    QVector<QLineF> lines;
    bool IsRemoveLast;
    bool IsHasP1;

};

#endif // DRAWLINE_H
