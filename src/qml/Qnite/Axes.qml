import QtQuick
import Qnite 1.0

/*! \qmltype Axes
    \inqmlmodule Qnite 0.1
    \ingroup figure

    \brief The container of all the axes and the ploy area

    TODO: add a long description
*/
BasicAxes {
    id: __plotarea

    /*! tick properties */
    AxisTick {
        id: __axistick
        thick: 1
        majSize: 10
        minSize: 3
        color: Qt.rgba(0,0,0,0.2)
    }
    property alias tick: __axistick

    // Optional names for the plot axis
    property string yAxisName: ""
    property string xAxisName: ""

    // Color for the plot labels, defaults to black
    property color xLabelsColor: "black"
    property color yLabelsColor: "black"

    // Plot background color, defaults to white
    property color backgroundColor: "white"

    property font labelFont

    property bool rotateBottomLabels: false
    property int bottomLabelHeight: 0

    TextMetrics {
        id: __metrics
        font: __plotarea.labelFont
        text: {
            if (axisY && axisY.labels && axisY.labels.length > 0) {
                return axisY.labels.reduce(function (a, b) {
                    return a.length > b.length ? a : b;
                });
            } else {
                return "0";
            }
        }
    }
    anchors {
        top: parent.top
        bottom: parent.bottom
        left: parent.left
        right: parent.right

        // We add left axis name height and bottom axis name width so that
        // if names are not empty they are correctly visualized
        topMargin: __metrics.height / 2 + __leftAxisName.height
        bottomMargin: __metrics.height + tick.majSize + 5 + bottomLabelHeight
        leftMargin: __metrics.width + tick.majSize + 5
        rightMargin: __metrics.width / 2 + __bottomAxisName.width
    }

    function majorTicksChanged(axis, labelsitem) {
        var values = [];
        for(var i = 0, item; (item = axis.majorTicks[i]) !== undefined; i++) {
            values.push({
                "value": item,
                "label": axis.labels[i]
            });
        }

        labelsitem.major = values;
    }

    function minorTicksChanged(axis, labelsitem) {
        var values = [];
        for(var i = 0, item; (item = axis.minorTicks[i]) !== undefined; i++) {
            values.push({ "value": item });
        }

        labelsitem.minor = values;
    }

    axisY: LinearAxis { flip: true }
    axisX: LinearAxis { }

    Binding {
        target: axisX
        property: "size"
        value: __plotarea.width
    }
    Binding {
        target: axisY
        property: "size"
        value: __plotarea.height
    }

    Connections {
        target: axisX

        function onMajorTicksChanged() { __plotarea.majorTicksChanged(axisX, __bottomlabels) }
        function onMinorTicksChanged() { __plotarea.minorTicksChanged(axisX, __bottomlabels) }
    }
    Connections {
        target: axisY

        function onMajorTicksChanged() { __plotarea.majorTicksChanged(axisY, __leftlabels) }
        function onMinorTicksChanged() { __plotarea.minorTicksChanged(axisY, __leftlabels) }
    }

    // TODO: expose as a property so it is customizable
    Rectangle {
        id: background
        anchors.fill: parent
        color: __plotarea.backgroundColor
        z: -1
    }

    Rectangle {
        id: bottombaseline
        implicitWidth: parent.width
        implicitHeight: tick.thick
        anchors.verticalCenter: parent.bottom
        anchors.alignWhenCentered: false
        color: tick.color
    }
    AxisLabel {
        id: __bottomlabels
        axisType: "bottom"
        width: __plotarea.width
        anchors.top: __plotarea.bottom
        anchors.left: __plotarea.left

        tick: __plotarea.tick
        labelFont: __plotarea.labelFont
        color: __plotarea.xLabelsColor

        rotateBottomLabels: __plotarea.rotateBottomLabels
    }
    // Name for the x Axis that the user can optionally set
    Text {
        id: __bottomAxisName
        anchors.left: __bottomlabels.right
        anchors.verticalCenter: __bottomlabels.bottom
        anchors.margins: 10
        text: __plotarea.xAxisName
        font: __plotarea.labelFont
        color: __plotarea.xLabelsColor
    }

    Rectangle {
        id: leftbaseline
        implicitWidth: tick.thick
        implicitHeight: parent.height
        anchors.horizontalCenter: parent.left
        anchors.alignWhenCentered: false
        color: tick.color
    }
    AxisLabel {
        id: __leftlabels
        axisType: "left"
        height: __plotarea.height
        anchors.bottom: __plotarea.bottom
        anchors.right: __plotarea.left

        tick: __plotarea.tick
        labelFont: __plotarea.labelFont
        color: __plotarea.yLabelsColor
    }
    // Name for the y Axis that the user can optionally set
    Text {
        id: __leftAxisName
        anchors.bottom: __leftlabels.top
        anchors.horizontalCenter: __leftlabels.left
        anchors.margins: 10
        text: __plotarea.yAxisName
        font: __plotarea.labelFont
        color: __plotarea.yLabelsColor
    }
}
