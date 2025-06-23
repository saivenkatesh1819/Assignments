//: [Previous](@previous)
/*:
 ## Retrospective TDD
 Given a UIKit view controller `ContentViewController` that *has a* `AnalyticsEventTracker` at runtime, write unit tests that cover the current implementation.
 */
import UIKit

/*
 An interface for tracking analytics events.
 */
protocol AnalyticsEventTracker {
    
    /**
     Adds the event to be tracked with the Analytics Event Manager. The event may be sent immediately or queued depending on the batch configuration setup.
     - Parameters:
       - event: the name of the event should not exceed 100 bytes.
       - payload: a dictionary of associated data sent with the event, both keys and values should not exceed 100 bytes, and should be limited to no more than 20 entries.
     */
    func track(event: String, payload: [String : AnyHashable])
}

/**
 A view controller that displays content cards in a list format, divided into sections.
 */
final class ContentViewController: UIViewController {
    
    private enum Section: String {
        case none, basic, standard, premium
    }
    
    /**
     The `currentSection` is updated at runtime as the user scrolls through the list.
     */
    private var currentSection: Section = .none
    
    // MARK: Dependencies
    var analyticsEventTracker: AnalyticsEventTracker!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        analyticsEventTracker.track(event: "content", payload: [
            "animated" : animated,
            "section" : currentSection.rawValue
        ])
    }
}

import XCTest



 class ContentViewControllerTests: XCTestCase {
    
     
     
}




ContentViewControllerTests.defaultTestSuite.run()



//: [Next](@next)
