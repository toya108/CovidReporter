import SwiftUI

struct ChartListView: View {

    @StateObject var viewModel = ChartListViewModel()

    var body: some View {
        VStack {
            InfectionChartView()
        }
    }
}

struct ChartListView_Previews: PreviewProvider {
    static var previews: some View {
        ChartListView()
    }
}
