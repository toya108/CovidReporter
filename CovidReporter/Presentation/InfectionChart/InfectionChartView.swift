import SwiftUI

struct InfectionChartView: View {

    @StateObject private var viewModel: InfectionChartViewModel = .init(
        getInfectionNumbersRepository: .init(),
        getAllInfectionNumbersRepository: .init()
    )
    @ObservedObject private var parentViewModel: ChartListViewModel
    private let prefecture: Prefecture

    init(prefecture: Prefecture, parentViewModel: ChartListViewModel) {
        self.prefecture = prefecture
        self.parentViewModel = parentViewModel
    }

    var body: some View {

        switch viewModel.state {
            case .standby:
                Color.clear.onAppear {
                    Task {
                        await viewModel.fetchInfectionNumbers(prefecture: prefecture)
                    }
                }
            case .loading:
                Color.clear

            case .finished(let dataSource):
                VStack(alignment: .leading) {
                    HStack {
                        Text(prefecture.rawValue).fontWeight(.heavy)
                        Spacer()
                        Text(
                            "\(dataSource.latestDate) 新規感染者数(\(Int(dataSource.latestAdpatients)))"
                        )
                        if prefecture != .all {
                            Button(
                                action: {
                                    parentViewModel.delete(prefecture: self.prefecture)
                                    parentViewModel.updatePrefectures()
                                },
                                label: {
                                    Image(systemName: "x.circle.fill")
                                        .foregroundColor(Color(uiColor: .systemTeal))
                                }
                            ).buttonStyle(.plain)
                        }
                    }
                    BarChart(dataSource: dataSource)
                }
                .padding(4)

            case .failed(let error):
                Color.clear
        }
    }
}

struct InfectionChartView_Previews: PreviewProvider {
    static var previews: some View {
        InfectionChartView(
            prefecture: .all,
            parentViewModel: .init(
                getPrefecturesRepository: .init(),
                setPrefecturesRepository: .init(),
                deletePrefecturesRepository: .init()
            )
        )
    }
}
