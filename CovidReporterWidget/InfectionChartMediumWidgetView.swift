import SwiftUI
import SwiftUICharts
import WidgetKit

 struct InfectionChartMediumWidgetView: View {

    var entry: InfectionNumberChartEntry

    init(entry: InfectionNumberChartEntry) {
        self.entry = entry
    }

     var body: some View {
         GeometryReader { content in
             VStack {
                 HStack {
                     Text(entry.prefecture.rawValue).fontWeight(.heavy)
                     let latestAdaptients = "(\(Int(entry.dataSource.latestAdpatients))人)"
                     Text(entry.dataSource.latestDate.description + "新規感染者数" + latestAdaptients)
                         .font(.system(size: 12))
                 }
                 BarChart()
                     .data(entry.dataSource.values)
                     .chartStyle(
                        .init(
                            backgroundColor: .teal,
                            foregroundColor: .init(.init(uiColor: .systemTeal))
                        )
                     )
                 HStack(spacing: 16) {
                     let width = content.size.width / CGFloat(entry.dataSource.dateStrings.count)
                     ForEach(entry.dataSource.dateStrings, id: \.self) {
                         Text($0).font(.system(size: 11))
                             .lineLimit(1)
                             .minimumScaleFactor(0.8)
                             .frame(maxWidth: width)
                     }
                 }
             }
             .padding(16)
         }
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
