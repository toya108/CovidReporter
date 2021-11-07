import SwiftUI

struct ChartListView: View {

    @StateObject var viewModel = ChartListViewModel(
        getPrefecturesRepository: .init(),
        setPrefecturesRepository: .init(),
        deletePrefecturesRepository: .init()
    )

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.prefectures) {
                    InfectionChartView(prefecture: $0, parentViewModel: viewModel)
                        .frame(height: 250)
                }
                SelectingPrefectureMenu(viewModel: viewModel)
            }
            .navigationBarTitle(Text("コロミル"), displayMode: .inline)
        }
        .onAppear {
            viewModel.updatePrefectures()
        }
    }
}

struct ChartListView_Previews: PreviewProvider {
    static var previews: some View {
        ChartListView()
    }
}
