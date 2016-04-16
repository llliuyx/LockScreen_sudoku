import QtQuick 2.3
import QtQuick.Window 2.2
import com.llliuyx.drawline 1.0

Window {
    visible: true

    Text {
        anchors{ bottom: circlesRect.top; bottomMargin: 100; horizontalCenter: circlesRect.horizontalCenter}
        font.pixelSize: 50
        text: circlesRect.isActiveString
    }

    Rectangle {
        id: circlesRect
        property bool isPainting
        property real spacing: 300
        property real radius: 30
        property real canActiveCircleRadius: circlesRect.radius * 3
        property var circles: [mapFromItem(rect0, circle0.centerPointX, circle0.centerPointY), mapFromItem(rect1, circle1.centerPointX, circle1.centerPointY), mapFromItem(rect2, circle2.centerPointX, circle2.centerPointY), mapFromItem(rect3, circle3.centerPointX, circle3.centerPointY), mapFromItem(rect4, circle4.centerPointX, circle4.centerPointY), mapFromItem(rect5, circle5.centerPointX, circle5.centerPointY), mapFromItem(rect6, circle6.centerPointX, circle6.centerPointY), mapFromItem(rect7, circle7.centerPointX, circle7.centerPointY), mapFromItem(rect8, circle8.centerPointX, circle8.centerPointY)]
        property var circleIds: [circle0, circle1, circle2, circle3, circle4, circle5, circle6, circle7, circle8]
        property string isActiveString: ""

        width: 900; height: 900
        border.color: "black"
        anchors.centerIn: parent
        Item {
            id: rect0
            x: 0; y: 0
            width: parent.spacing; height: width
            Circle {
                id: circle0
                radius: circlesRect.radius
                anchors.centerIn: parent
            }
        }
        Item {
            id: rect1
            x: parent.spacing; y: 0;
            width: parent.spacing; height: width
            Circle {
                id: circle1
                radius: circlesRect.radius
                anchors.centerIn: parent
            }
        }
        Item {
            id: rect2
            x: parent.spacing * 2; y: 0;
            width: parent.spacing; height: width
            Circle {
                id: circle2
                radius: circlesRect.radius
                anchors.centerIn: parent
            }
        }
        Item {
            id: rect3
            x: 0; y: parent.spacing;
            width: parent.spacing; height: width
            Circle {
                id: circle3
                radius: circlesRect.radius
                anchors.centerIn: parent
            }
        }
        Item {
            id: rect4
            x: parent.spacing; y: parent.spacing;
            width: parent.spacing; height: width
            Circle {
                id: circle4
                radius: circlesRect.radius
                anchors.centerIn: parent
            }
        }
        Item {
            id: rect5
            x: parent.spacing * 2; y: parent.spacing;
            width: parent.spacing; height: width
            Circle {
                id: circle5
                radius: circlesRect.radius
                anchors.centerIn: parent
            }
        }
        Item {
            id: rect6
            x: 0; y: parent.spacing * 2;
            width: parent.spacing; height: width
            Circle {
                id: circle6
                radius: circlesRect.radius
                anchors.centerIn: parent
            }
        }
        Item {
            id: rect7
            x: parent.spacing; y: parent.spacing * 2;
            width: parent.spacing; height: width
            Circle {
                id: circle7
                radius: circlesRect.radius
                anchors.centerIn: parent
            }
        }
        Item {
            id: rect8
            x: parent.spacing * 2; y: parent.spacing * 2;
            width: parent.spacing; height: width
            Circle {
                id: circle8
                radius: circlesRect.radius
                anchors.centerIn: parent
            }
        }

        DrawLine {
            id: drawLine
            anchors.fill: parent
        }

        MouseArea {
            id: circlesRectMouse
            anchors.fill: parent
            onPressed: {
                circlesRect.resetPaintLine()
                for(var i = 0; i < circlesRect.circles.length; i++) {
                    if(!circlesRect.circleIds[i].isActive) {
                        if(Math.abs(mouse.x - circlesRect.circles[i].x) <= circlesRect.canActiveCircleRadius && Math.abs(mouse.y - circlesRect.circles[i].y) <= circlesRect.canActiveCircleRadius) {
                            circlesRect.circleIds[i].isActive = true
                            circlesRect.isActiveString += i.toString()
                            drawLine.setDrawLineP1(Qt.point(circlesRect.circles[i].x, circlesRect.circles[i].y))
                            return
                        }
                    }

                }

            }
            onReleased: {
                circlesRect.isPainting = false
                drawLine.finishedDrawLine()
            }
            onPositionChanged: {
                if(!drawLine.hasP1()) {
                    for(var i = 0; i < circlesRect.circles.length; i++) {
                        if(!circlesRect.circleIds[i].isActive) {
                            if(Math.abs(mouse.x - circlesRect.circles[i].x) <= circlesRect.canActiveCircleRadius && Math.abs(mouse.y - circlesRect.circles[i].y) <= circlesRect.canActiveCircleRadius) {
                                circlesRect.circleIds[i].isActive = true
                                circlesRect.isActiveString += i.toString()
                                drawLine.setDrawLineP1(Qt.point(circlesRect.circles[i].x, circlesRect.circles[i].y))
                                return
                            }
                        }

                    }
                }
                else {
                    drawLine.setDrawLineP2(Qt.point(mouse.x, mouse.y))
                    for(var i = 0; i < circlesRect.circles.length; i++) {
                        if(!circlesRect.circleIds[i].isActive) {
                            if(Math.abs(mouse.x - circlesRect.circles[i].x) <= circlesRect.canActiveCircleRadius && Math.abs(mouse.y - circlesRect.circles[i].y) <= circlesRect.canActiveCircleRadius) {//cross the circle
                                var p1 = drawLine.getP1()
                                var midPointX = (p1.x + circlesRect.circles[i].x) / 2
                                var midPointY = (p1.y + circlesRect.circles[i].y) / 2
                                for(var j = 0; j < circlesRect.circles.length; j++) {
                                    if(Math.abs(midPointX - circlesRect.circles[j].x) <= circlesRect.canActiveCircleRadius && Math.abs(midPointY - circlesRect.circles[j].y) <= circlesRect.canActiveCircleRadius) {//cross the circle
                                        circlesRect.circleIds[j].isActive = true
                                        circlesRect.isActiveString += j.toString()
                                        drawLine.addLine(Qt.point(circlesRect.circles[j].x, circlesRect.circles[j].y))
                                        return
                                    }
                                }

                                circlesRect.circleIds[i].isActive = true
                                circlesRect.isActiveString += i.toString()
                                drawLine.addLine(Qt.point(circlesRect.circles[i].x, circlesRect.circles[i].y))
                                return
                            }
//                            else {//以下算法使用点到直线的距离，计算线飘过点的情况，当点距离线一定距离后，连接该点
//                                var p1 = drawLine.getP1()
//                                if((Math.pow((p1.x - mouse.x), 2) + Math.pow((p1.y - mouse.y), 2)) > (Math.pow((p1.x - circlesRect.circles[i].x), 2) + Math.pow((p1.y - circlesRect.circles[i].y), 2))) {//排除线还未到达该点的情况
//                                    if((p1.x < mouse.x && p1.x < circlesRect.circles[i].x) || (p1.x > mouse.x && p1.x > circlesRect.circles[i].x) || (p1.y < mouse.y && p1.y < circlesRect.circles[i].y) || (p1.y > mouse.y && p1.y > circlesRect.circles[i].y)) {//排除与某点反方向的另一点
//                                        //点到直线的距离公式
//                                        var numerator = Math.abs( (mouse.y - p1.y)*circlesRect.circles[i].x + (p1.x - mouse.x)*circlesRect.circles[i].y + (mouse.x * p1.y - p1.x * mouse.y) )//|Ax + By + c|
//                                        var denominator  = Math.sqrt(Math.pow((mouse.y - p1.y), 2) + Math.pow((p1.x - mouse.x), 2)) //sqrt(A*A + B*B)
//                                        var d = numerator / denominator
//                                        if(d <= circlesRect.canActiveCircleRadius) {
//                                            var midPointX2 = (p1.x + circlesRect.circles[i].x) / 2
//                                            var midPointY2 = (p1.y + circlesRect.circles[i].y) / 2
//                                            for(var j = 0; j < circlesRect.circles.length; j++) {
//                                                 if(Math.abs(midPointX2 - circlesRect.circles[j].x) <= circlesRect.canActiveCircleRadius && Math.abs(midPointY2 - circlesRect.circles[j].y) <= circlesRect.canActiveCircleRadius) {//cross the circle
//                                                     circlesRect.circleIds[j].isActive = true
//                                                     circlesRect.isActiveString += j.toString()
//                                                     drawLine.addLine(Qt.point(circlesRect.circles[j].x, circlesRect.circles[j].y))
//                                                     return
//                                                 }
//                                            }
//                                           circlesRect.circleIds[i].isActive = true
//                                            circlesRect.isActiveString += i.toString()
//                                            drawLine.addLine(Qt.point(circlesRect.circles[i].x, circlesRect.circles[i].y))

//                                        }
//                                    }

//                                }

//                            }

                        }

                    }
                }
            }           
        }

        function resetPaintLine() {
            for(var i = 0; i < circlesRect.circleIds.length; i++) {
                circlesRect.circleIds[i].isActive = false
                circlesRect.circleIds[i].radius = circlesRect.radius
            }
            drawLine.clearLines()
            circlesRect.isActiveString = ""
        }
    }

}

