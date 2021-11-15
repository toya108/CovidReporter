import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {
        VStack {
            List {
                Text("アプリ設定").onTapGesture {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
                Text("レビューを書く").onTapGesture {
                    guard
                        let scene = UIApplication.shared.connectedScenes.first(
                            where: { $0.activationState == .foregroundActive }
                        ) as? UIWindowScene
                    else {
                        return
                    }

                    SKStoreReviewController.requestReview(in: scene)
                }
            }
            Text("コロミル v" + (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
