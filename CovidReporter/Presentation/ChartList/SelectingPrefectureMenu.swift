import SwiftUI

struct SelectingPrefectureMenu: View {

    @ObservedObject var viewModel: ChartListViewModel

    var body: some View {
        Menu(
            content: {
                ForEach(
                    Prefecture.allCases
                        .filter { $0 != .all }
                        .filter { !viewModel.prefectures.contains($0) }
                ) {
                    let prefecture = $0
                    Button(prefecture.rawValue) {
                        viewModel.set(prefecture: prefecture)
                        viewModel.updatePrefectures()
                    }
                }
            },
            label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus.circle.fill")
                        .frame(height: 64)
                        .foregroundColor(Color(uiColor: .systemTeal))
                    Spacer()
                }
            }
        )
    }
}

struct SelectingPrefectureMenu_Previews: PreviewProvider {
    static var previews: some View {
        SelectingPrefectureMenu(
            viewModel: .init(
                getPrefecturesRepository: .init(),
                setPrefecturesRepository: .init(),
                deletePrefecturesRepository: .init()
            )
        )
    }
}
