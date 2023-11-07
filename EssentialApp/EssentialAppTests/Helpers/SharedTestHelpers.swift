import FeedPresentation
import SharedPresentation

var feedTitle: String {
    FeedPresenter.title
}

private class DummyView: ResourceView {
    func display(_ viewModel: Any) {}
}

var loadError: String {
    LoadResourcePresenter<Any, DummyView>.loadError
}
