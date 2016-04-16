import QtQuick 2.0

Rectangle {
    id: circleRect

    property real centerPointX: x + width / 2
    property real centerPointY: y + height / 2
    property bool isActive: false

    width: radius * 2; height: width

    states: [
        State {
            name: "isActive"; when: circleRect.isActive
            PropertyChanges {
                target: circleRect
                color: "red"
            }
        },
        State {
            name: "notActive"; when: !circleRect.isActive
            PropertyChanges {
                target: circleRect
                color: "lightgrey"
            }
        }
    ]

    transitions: Transition {
        from: "notActive"; to: "isActive"
        SequentialAnimation {
            NumberAnimation { target: circleRect; property: "radius";from: circleRect.radius; to: circleRect.radius + 10; duration: 200; easing.type: Easing.OutQuad }
            NumberAnimation { target: circleRect; property: "radius";from: circleRect.radius + 10; to: circleRect.radius; duration: 200; easing.type: Easing.InQuad }
        }
    }

}
