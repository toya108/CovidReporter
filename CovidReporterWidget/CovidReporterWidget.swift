import WidgetKit
import SwiftUI
import Intents
import SwiftUICharts

struct Provider: IntentTimelineProvider {

    private let getAllInfectionNumbersRepository = Repositories.InfectionNumbers.All.Get()

    func placeholder(in context: Context) -> InfectionNumberChartEntry {
        InfectionNumberChartEntry(
            date: Date(),
            dataSource: .init(),
            prefecture: .all
        )
    }

    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (InfectionNumberChartEntry) -> Void
    ) {

        Task {
            do {
                let infectionNumbers = try await getAllInfectionNumbersRepository.request()
                let latest = Array(infectionNumbers.suffix(7))
                let entry = InfectionNumberChartEntry(
                    date: Date(),
                    dataSource: .init(dataEntryConvertibles: latest),
                    prefecture: .all
                )
                completion(entry)

            } catch {

            }
        }
    }

    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> Void
    ) {
        Task {
            do {
                let infectionNumbers = try await getAllInfectionNumbersRepository.request()
                let latest = Array(infectionNumbers.suffix(7))
                let entry = InfectionNumberChartEntry(
                    date: Date(),
                    dataSource: .init(dataEntryConvertibles: latest),
                    prefecture: .all
                )
                let refreshInterval = Calendar.current.date(
                    byAdding: .hour,
                    value: 6,
                    to: Date()
                ) ?? Date()
                let timeline = Timeline(
                    entries: [entry],
                    policy: .after(refreshInterval)
                )
                completion(timeline)
            } catch {

            }
        }
    }
}

struct InfectionNumberChartEntry: TimelineEntry {
    let date: Date
    let dataSource: BarChartDataSource
    let prefecture: Prefecture
}

struct CovidReporterWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        InfectionChartMediumWidgetView(entry: entry)
    }
}

@main
struct CovidReporterWidget: Widget {
    let kind: String = "CovidReporterWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            CovidReporterWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("コロミル")
        .description("コロナの新規感染者数をいつでもチェック")
        .supportedFamilies([.systemMedium])
    }
}

 struct CovidReporterWidget_Previews: PreviewProvider {
    static var previews: some View {
        CovidReporterWidgetEntryView(
            entry: InfectionNumberChartEntry(
                date: Date(),
                dataSource: .init(),
                prefecture: .all
            )
        )
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
 }
