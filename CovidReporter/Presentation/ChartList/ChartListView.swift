import SwiftUI

struct ChartListView: View {

    @StateObject var viewModel = ChartListViewModel(
        getPrefecturesRepository: .init(),
        setPrefecturesRepository: .init(),
        deletePrefecturesRepository: .init()
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
                .navigationBarTitle(Text("コロミル"), displayMode: .inline)
                Text("※ 内閣官房新型コロナウイルス感染症対策推進室の[オープンデータ](https://corona.go.jp/dashboard/)を元に表示しています。")
                    .font(.system(size: 11))
                    .padding()
            }
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
