import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
    func providePrefectureOptionsCollection(
        for intent: ConfigurationIntent,
        with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void
    ) {
        let strings = Prefecture.allCases.map(\.rawValue).map { NSString(string: $0) }
        completion(.init(items: strings), nil)
    }

    override func handler(for intent: INIntent) -> Any {
        return self
    }

}
