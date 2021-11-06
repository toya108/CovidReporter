import SwiftUI

struct InfectionChartView: View {

    @StateObject var viewModel = InfectionChartViewModel(
        prefecture: .all,
        getInfectionNumbersRepository: .init()
    )

    var body: some View {
        BarChart(entries: $viewModel.entries)
            .onAppear {
                Task {
                    await viewModel.fetchAllInfectionNumbers()
                }
            }
    }
}

struct InfectionChartView_Previews: PreviewProvider {
    static var previews: some View {
        InfectionChartView()
    }
}
