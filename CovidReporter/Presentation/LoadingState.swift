enum LoadingState<T> {
    case standby
    case loading
    case finished(T)
    case failed(Error)
}
