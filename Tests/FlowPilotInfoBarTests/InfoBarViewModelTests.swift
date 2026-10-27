#if canImport(UIKit)
import Testing
@testable import FlowPilotInfoBar

@MainActor
@Suite("InfoBarViewModel")
struct InfoBarViewModelTests {
    @Test("is released before its auto-hide fires, so a bar retired early does not outlive its duration")
    func releasedBeforeAutoHide() {
        weak var weakViewModel: InfoBarViewModel<String>?
        do {
            let viewModel = InfoBarViewModel(content: "Message", hideAfter: 30)
            weakViewModel = viewModel
        }
        #expect(weakViewModel == nil)
    }

    @Test("still hides itself once its duration passes")
    func hidesAfterDuration() async throws {
        let viewModel = InfoBarViewModel(content: "Message", hideAfter: 1)
        viewModel.isMessageShown = true
        try await Task.sleep(for: .milliseconds(1500))
        #expect(viewModel.isMessageShown == false)
    }
}
#endif
