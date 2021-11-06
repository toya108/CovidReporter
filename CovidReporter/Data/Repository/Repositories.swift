struct Repositories {
    struct InfectionNumbers {
        struct All {
            typealias Get = Repository<GetAllInfectionNumbers>
        }
        struct Prefecture {
            typealias Get = Repository<GetInfectionNumbers>
        }
    }
}
