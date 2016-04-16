#include "drawline.h"

DrawLine::DrawLine()
{
    IsRemoveLast = false;
    IsHasP1 = false;
}

void DrawLine::paint(QPainter *painter)
{
    if(lines.size() == 0) {
        return;
    }
    QPen pen;
    pen.setColor("red");
    pen.setWidth(15);
    painter->setPen(pen);
    painter->setRenderHint(QPainter::Antialiasing, true);//反锯齿
    painter->drawLines(lines);
}
void DrawLine::setDrawLineP1(const QPointF& p1)
{
    line.setP1(p1);
    IsHasP1 = true;
}
void DrawLine::setDrawLineP2(const QPointF& p2)
{
    if(IsRemoveLast) {
        lines.removeLast();
    }
    line.setP2(p2);
    lines.append(line);
    IsRemoveLast = true;
    update();
}
void DrawLine::addLine(const QPointF &p2)
{
    if(IsRemoveLast) {
        lines.removeLast();
    }
    line.setP2(p2);
    lines.append(line);
    setDrawLineP1(p2);
    IsRemoveLast = false;
    update();
}
void DrawLine::finishedDrawLine()
{
    if(IsRemoveLast) {
        lines.removeLast();
    }
    IsRemoveLast = false;
    update();
}
QPointF DrawLine::getP1()
{
    return line.p1();
}
bool DrawLine::hasP1()
{
    return IsHasP1;
}

void DrawLine::clearLines()
{
    lines.clear();
    IsRemoveLast = false;
    IsHasP1 = false;
    update();
}
