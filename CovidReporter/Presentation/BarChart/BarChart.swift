import Charts
import SwiftUI

struct BarChart: UIViewRepresentable {

    @Binding var dataSource: BarChartDataSource

    typealias UIViewType = BarChartView

    init(dataSource: Binding<BarChartDataSource>) {
        self._dataSource = dataSource
    }

    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.granularity = 1.0
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.drawAxisLineEnabled = false
        chart.leftAxis.drawZeroLineEnabled = true
        chart.leftAxis.drawAxisLineEnabled = false

        chart.rightAxis.enabled = false
        chart.legend.enabled = false

        return chart
    }

    func updateUIView(_ uiView: BarChartView, context: Context) {
        uiView.data = data
        uiView.xAxis.valueFormatter = dataSource.dateValueFormatter
    }

    private var data: ChartData {
        let dataSet = BarChartDataSet(entries: dataSource.dataEntryConvertibles.entries)
        dataSet.valueFont = NSUIFont.systemFont(ofSize: 10)
        let data = BarChartData(dataSet: dataSet)
        return data
    }
}
