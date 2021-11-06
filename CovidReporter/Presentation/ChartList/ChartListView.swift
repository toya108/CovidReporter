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
            .navigationBarItems(
                trailing: Button(
                    action: {

                    },
                    label: {
                        Image(systemName: "gear")
                            .foregroundColor(Color(uiColor: .label))
                    }
                )
            )
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
