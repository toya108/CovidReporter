import SwiftUI

struct ChartListView: View {

    @StateObject var viewModel = ChartListViewModel()

    var body: some View {
        NavigationView {
            List {
                InfectionChartView(prefecture: .all).frame(minHeight: 250)
                InfectionChartView(prefecture: .hokkaido).frame(minHeight: 250)
                Button(
                    action: {

                    },
                    label: {
                        HStack {
                            Spacer()
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color(uiColor: .label))
                                .frame(height: 64)
                            Spacer()
                        }

                    }
                )
                
            }
            .navigationBarTitle(Text("コロミル"), displayMode: .inline)
            .navigationBarItems(
                trailing: Button(
                    action: {

                    },
                    label: {
                        Image(systemName: "gear").foregroundColor(Color(uiColor: .label))
                    }
                )
            )
        }
    }
}

struct ChartListView_Previews: PreviewProvider {
    static var previews: some View {
        ChartListView()
    }
}
