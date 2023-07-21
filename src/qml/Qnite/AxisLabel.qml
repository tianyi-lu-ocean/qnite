import QtQuick
import Qnite 1.0

Item {
    id: axis

    property AxisTick tick

    property string axisType
    property font labelFont

    property var major;
    property var minor;

    property color color;
    property bool rotateBottomLabels: false;

    Item {
        id: ticksnlabels
        anchors.fill: parent

        Repeater {
            model: axis.major
            Loader {
                property real val: modelData.value
                property string label: modelData.label
                property real size: axis.tick.majSize

                anchors {
                    right: axis.axisType === "left" ? ticksnlabels.right : undefined
                    rightMargin: axis.axisType === "left" ? tick.thick / 2 : 0
                }
                sourceComponent: axis.axisType === "left" ? leftTick : bottomTick
            }
        }

        Repeater {
            model: axis.minor
            Loader {
                property real val: modelData.value
                property string label: ""
                property real size: axis.tick.minSize

                anchors {
                    right: axis.axisType === "left" ? ticksnlabels.right : undefined
                    rightMargin: axis.axisType === "left" ? tick.thick / 2 : 0
                }
                sourceComponent: axis.axisType === "left" ? leftTick : bottomTick
            }
        }
    }

    Component {
        id: leftTick
        Row {
            spacing: 5

            Binding on y {
                // align the center of the tick with the data value
                value: val - tick.thick / 2
            }

            Text {
                id: __text
                anchors.verticalCenter: __tick.verticalCenter
                font: axis.labelFont
                text: label

                color: axis.color
            }

            Rectangle {
                id: __tick
                implicitWidth: size
                implicitHeight: tick.thick

                color: tick.color
            }
        }
    }

    Component {
        id: bottomTick

        Column {
            spacing: 5

            Binding on x {
                // align the center of the tick with the data value
                value: val - tick.thick / 2
            }

            Rectangle {
                id: __tick
                implicitWidth: tick.thick
                implicitHeight: size

                color: tick.color
            }

            Text {
                id: __text
                anchors.horizontalCenter: axis.rotateBottomLabels ? undefined : __tick.horizontalCenter
                anchors.right: axis.rotateBottomLabels ? __tick.horizontalCenter : undefined
                font: axis.labelFont
                text: label

                color: axis.color
                transformOrigin: axis.rotateBottomLabels ? Item.Right : Item.Center
                rotation: axis.rotateBottomLabels ? -45 : 0
            }
        }
    }
}
