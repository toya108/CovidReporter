import SwiftUI

struct ChartListView: View {

    @StateObject var viewModel = ChartListViewModel(
        getPrefecturesRepository: AnyRepository(Repositories.Prefectures.Get()),
        setPrefecturesRepository: AnyRepository(Repositories.Prefectures.Set()),
        deletePrefecturesRepository: AnyRepository(Repositories.Prefectures.Delete())
    )

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.prefectures) {
                        InfectionChartView(prefecture: $0, parentViewModel: viewModel)
                            .frame(height: 250)
                    }
                    SelectingPrefectureMenu(viewModel: viewModel)
                }
                .navigationTitle("コロミル")
                .navigationBarTitleDisplayMode(.inline)

                Text("※ 内閣官房新型コロナウイルス感染症対策推進室の[オープンデータ](https://corona.go.jp/dashboard/)を元に表示しています。")
                    .font(.system(size: 11))
                    .padding()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
