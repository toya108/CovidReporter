import SwiftUI

struct InfectionChartView: View {

    @StateObject private var viewModel: InfectionChartViewModel = .init(
        getInfectionNumbersRepository: .init(),
        getAllInfectionNumbersRepository: .init()
    )
    private let prefecture: Prefecture

    init(prefecture: Prefecture) {
        self.prefecture = prefecture
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(prefecture.rawValue).fontWeight(.heavy)
                Spacer()
                Text(
                    "\(viewModel.dataSource.latestDate) 新規感染者数(\(Int(viewModel.dataSource.latestAdpatients)))"
                )
            }
            BarChart(dataSource: $viewModel.dataSource)
                .onAppear {
                    Task {
                        await viewModel.fetchInfectionNumbers(prefecture: prefecture)
                    }
                }
        }
        .padding(4)
    }
}

struct InfectionChartView_Previews: PreviewProvider {
    static var previews: some View {
        InfectionChartView(prefecture: .all)
    }
}
