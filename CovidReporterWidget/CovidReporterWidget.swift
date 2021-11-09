import WidgetKit
import SwiftUI
import Intents
import SwiftUICharts

struct Provider: IntentTimelineProvider {

    typealias Intent = ConfigurationIntent

    private let getAllInfectionNumbersRepository = Repositories.InfectionNumbers.All.Get()
    private let getInfectionNumbersRepository = Repositories.InfectionNumbers.Prefecture.Get()

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

        let days = DateGenerator.generatePastDays(from: Date(), difference: 1, to: 8).map {
            DateConverter.convert(from: $0).filter { $0 != "/" }
        }
        async let first = self.getInfectionNumbersRepository.request(
            parameters: .init(date: days[0], dataName: prefecture.rawValue)
        )
        async let second = self.getInfectionNumbersRepository.request(
            parameters: .init(date: days[1], dataName: prefecture.rawValue)
        )
        async let third = self.getInfectionNumbersRepository.request(
            parameters: .init(date: days[2], dataName: prefecture.rawValue)
        )
        async let fourth = self.getInfectionNumbersRepository.request(
            parameters: .init(date: days[3], dataName: prefecture.rawValue)
        )
        async let fifth = self.getInfectionNumbersRepository.request(
            parameters: .init(date: days[4], dataName: prefecture.rawValue)
        )
        async let sixth = self.getInfectionNumbersRepository.request(
            parameters: .init(date: days[5], dataName: prefecture.rawValue)
        )
        async let seventh = self.getInfectionNumbersRepository.request(
            parameters: .init(date: days[6], dataName: prefecture.rawValue)
        )
        async let eigth = self.getInfectionNumbersRepository.request(
            parameters: .init(date: days[7], dataName: prefecture.rawValue)
        )

        let infectionNumbers = try await [
            eigth, seventh, sixth, fifth, fourth, third, second, first
        ]
        return AdpatientsCalculator.addAdpatients(from: infectionNumbers)
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
