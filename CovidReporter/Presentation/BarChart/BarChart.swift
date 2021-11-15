import Charts
import SwiftUI

struct VerticalBarChart: UIViewRepresentable {

    var dataSource: BarChartDataSource

    typealias UIViewType = BarChartView

    init(dataSource: BarChartDataSource) {
        self.dataSource = dataSource
    }

    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        chart.scaleXEnabled = false
        chart.scaleYEnabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.granularity = 1.0
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.drawAxisLineEnabled = false
        chart.leftAxis.axisMinimum = 0.0
        chart.leftAxis.drawZeroLineEnabled = true
        chart.leftAxis.drawAxisLineEnabled = false
        chart.rightAxis.enabled = false
        chart.legend.enabled = false

        chart.data = data
        chart.xAxis.valueFormatter = dataSource.dateValueFormatter

        return chart
    }

    func updateUIView(_ uiView: BarChartView, context: Context) {}

    private var data: ChartData {
        let dataSet = BarChartDataSet(entries: dataSource.entries)
        dataSet.highlightEnabled = false
        dataSet.colors = [.systemTeal]
        dataSet.valueFont = NSUIFont.systemFont(ofSize: 10)
        let data = BarChartData(dataSet: dataSet)
        return data
    }
}
