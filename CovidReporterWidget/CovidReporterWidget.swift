import WidgetKit
import SwiftUI
import Intents
import SwiftUICharts

struct Provider: IntentTimelineProvider {

    typealias Intent = ConfigurationIntent

    private let getAllInfectionNumbersRepository = AnyRepository(Repositories.InfectionNumbers.All.Get())
    private let getInfectionNumbersRepository = AnyRepository(Repositories.InfectionNumbers.Prefecture.Get())

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
                let prefecture = Prefecture(rawValue: configuration.prefecture ?? "") ?? .all
                let sources = try await fetchInfectionNumbers(prefecture: prefecture)
                let entry = InfectionNumberChartEntry(
                    date: Date(),
                    dataSource: .init(dataEntryConvertibles: sources),
                    prefecture: prefecture
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
                let prefecture = Prefecture(rawValue: configuration.prefecture ?? "") ?? .all
                let sources = try await fetchInfectionNumbers(prefecture: prefecture)
                let entry = InfectionNumberChartEntry(
                    date: Date(),
                    dataSource: .init(dataEntryConvertibles: sources),
                    prefecture: prefecture
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

    private func fetchInfectionNumbers(prefecture: Prefecture) async throws -> [BarChartDataEntryConvertible] {
        prefecture == .all
        ? try await fetchAllInfectionNumbers()
        : try await fetchInfectionNumbers(per: prefecture)
    }

    private func fetchAllInfectionNumbers() async throws -> [BarChartDataEntryConvertible] {
        let infectionNumbers = try await getAllInfectionNumbersRepository.request()
        return  Array(infectionNumbers.suffix(7))
    }

    private func fetchInfectionNumbers(
        per prefecture: Prefecture
    ) async throws -> [BarChartDataEntryConvertible] {
        let infectionNumbers = try await getInfectionNumbersRepository.request(
            parameters: .init(dataName: prefecture.rawValue)
        )
        let eightDays = Array(infectionNumbers.itemList.prefix(8).reversed())
        return AdpatientsCalculator.addAdpatients(from: eightDays)
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
