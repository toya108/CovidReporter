import Charts
import SwiftUI

struct BarChart: UIViewRepresentable {

    @Binding var entries: [BarChartDataEntry]

    typealias UIViewType = BarChartView

    init(entries: Binding<[BarChartDataEntry]>) {
        self._entries = entries
    }

    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        chart.data = data
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.valueFormatter = DateValueFormatter(startDate: Date())
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
    }

    private var data: ChartData {
        let dataSet = BarChartDataSet(entries: entries)
        let data = BarChartData(dataSet: dataSet)
        return data
    }
}
