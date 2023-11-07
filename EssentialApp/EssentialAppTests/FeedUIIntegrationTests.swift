
import XCTest
import FeedFeature
import SharedUI
import Combine
import FeedPresentation
import EssentialApp

class FeedUIIntegrationTests: XCTestCase {

    func test_feedView_hasTitle() {
        let (sut, _) = makeSUT()

        sut.simulateAppearance()

        XCTAssertEqual(sut.title, FeedPresenter.title)
    }

//    func test_loadFeedCompletion_rendersSuccessfullyLoadedFeed() {
//        let image0 = makeImage(description: "a description", location: "a location")
//        let image1 = makeImage(description: nil, location: "another location")
//        let (sut, loader) = makeSUT()
//
//        sut.loadViewIfNeeded()
//        assertThat(sut, isRendering: [])
//
//        loader.completeFeedLoading(with: [image0, image1], at: 0)
//        assertThat(sut, isRendering: [image0, image1])
//    }
    
    private func makeSUT(
        selection: @escaping (FeedImage) -> Void = { _ in },
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: ListViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = FeedUIComposer.feedComposedWith(
            feedLoader: loader.loadPublisher,
            selection: selection
        )
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }


    private func makeImage(description: String? = nil, location: String? = nil, url: URL = URL(string: "http://any-url.com")!) -> FeedImage {
        return FeedImage(id: UUID(), description: description, location: location, url: url)
    }

}
