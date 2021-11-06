import Foundation
import Combine
import Charts

final class InfectionChartViewModel: ObservableObject {

    @Published var entries: [BarChartDataEntry] = []
    @Published var error: Error?

    let prefecture: Prefecture
    let getInfectionNumbersRepository: Repositories.InfectionNumbers.Get

    init(
        prefecture: Prefecture,
        getInfectionNumbersRepository: Repositories.InfectionNumbers.Get
    ) {
        self.prefecture = prefecture
        self.getInfectionNumbersRepository = getInfectionNumbersRepository
    }

    @MainActor func fetchAllInfectionNumbers() async {

        let sevenDays = DateGenerator.generatePastDays(from: Date(), difference: 2, to: 7).map {
            DateConverter.convert(from: $0).filter { $0 != "/" }
        }

        do {
            async let first = self.getInfectionNumbersRepository.request(
                parameters: .init(date: sevenDays[0])
            )
            async let second = self.getInfectionNumbersRepository.request(
                parameters: .init(date: sevenDays[1])
            )
            async let third = self.getInfectionNumbersRepository.request(
                parameters: .init(date: sevenDays[2])
            )
            async let fourth = self.getInfectionNumbersRepository.request(
                parameters: .init(date: sevenDays[3])
            )
            async let fifth = self.getInfectionNumbersRepository.request(
                parameters: .init(date: sevenDays[4])
            )
            async let sixth = self.getInfectionNumbersRepository.request(
                parameters: .init(date: sevenDays[5])
            )
            async let seventh = self.getInfectionNumbersRepository.request(
                parameters: .init(date: sevenDays[6])
            )

            self.entries = try await [first, second, third, fourth, fifth, sixth, seventh]
                .reversed()
                .enumerated()
                .map { offset, element in
                    let infectionNumberPerDay = ToAllInfectionNumbers.map(from: element)
                    return .init(
                        x: Double(offset),
                        y: Double(infectionNumberPerDay.infectionNumber)
                    )
                }

        } catch {
            self.error = error
        }
    }

}
