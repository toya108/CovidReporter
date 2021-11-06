struct Repositories {
    struct InfectionNumbers {
        struct All {
            typealias Get = Repository<GetAllInfectionNumbers>
        }
        struct Prefecture {
            typealias Get = Repository<GetInfectionNumbers>
        }
    }
    struct Prefectures {
        typealias Get = Repository<GetPrefecturesRequest>
        typealias Set = Repository<SetPrefecturesRequest>
        typealias Delete = Repository<DeletePrefecturesRequest>
    }
}
