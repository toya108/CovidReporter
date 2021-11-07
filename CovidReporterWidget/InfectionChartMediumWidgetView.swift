import SwiftUI
import SwiftUICharts
import WidgetKit

 struct InfectionChartMediumWidgetView: View {

    var entry: InfectionNumberChartEntry

    init(entry: InfectionNumberChartEntry) {
        self.entry = entry
    }

     var body: some View {
         VStack {
             HStack {
                 Text(entry.prefecture.rawValue).fontWeight(.heavy)
                 // Textの初期化時にIntをインラインで埋め込むと表示されない不具合のため一時変数で宣言しています。
                 let latestAdaptients = "(\(Int(entry.dataSource.latestAdpatients))人)"
                 Text(entry.dataSource.latestDate.description + "新規感染者数" + latestAdaptients)
                     .font(.system(size: 12))
             }
             let data = makeData(from: entry)
             BarChart(chartData: data)
                 .yAxisGrid(chartData: data)
                 .xAxisLabels(chartData: data)
         }
         .padding(12)
     }

     private func makeData(from entry: InfectionNumberChartEntry) -> BarChartData {
         let dataSet = BarDataSet(
            dataPoints: entry.dataSource.dataEntryConvertibles.map {
                .init(
                    value: $0.yData,
                    xAxisLabel: DateConverter.convert(from: $0.dateForSource, template: .date)
                )
            }
         )
         let gridStyle = GridStyle(
            numberOfLines: 4,
            lineColour: Color(.lightGray).opacity(0.25),
            lineWidth: 1
         )
         let data = BarChartData(
            dataSets: dataSet,
            barStyle: .init(
                barWidth: 0.6,
                colourFrom: .barStyle,
                colour: .init(colour: Color(uiColor: .systemTeal))
            ),
            chartStyle: .init(yAxisGridStyle: gridStyle)
         )
         return data
     }
 }

 struct InfectionChartMediumWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        InfectionChartMediumWidgetView(
            entry: .init(
                date: Date(),
                dataSource: .init(),
                prefecture: .all
            )
        )
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
 }
