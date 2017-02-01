import XCTest
import Spots
import RxSpots
import RxSwift
import Brick

class RxSpotsDelegateTests: XCTestCase {

  var delegateProxy: RxSpotsDelegate!
  private let disposeBag = DisposeBag()

  override func setUp() {
    super.setUp()
    let controller = Controller()

    delegateProxy = RxSpotsDelegate(parentObject: controller)
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testDidSelectItem() {
    let spot = ListSpot()
    let item = Item(title: "Test")
    var isCalled = false

    delegateProxy.didSelectItem.bindNext { spot, item in
      isCalled = (spot is ListSpot) && item.title == "Test"
    }.addDisposableTo(disposeBag)

    delegateProxy.spotable(spot, itemSelected: item)

    XCTAssertTrue(isCalled)
  }
  
  func testDidChange() {
    let listSpot = ListSpot()
    let gridSpot = GridSpot()
    var isCalled = false

    delegateProxy.didChange
      .bindNext({ spots in
        isCalled = (spots[0] is ListSpot) && (spots[1] is GridSpot)
      })
      .addDisposableTo(disposeBag)

    delegateProxy.spotablesDidChange([listSpot, gridSpot])

    XCTAssertTrue(isCalled)
  }

  func testWillDisplayView() {

  }

  func testDidEndDisplayingView() {

  }
}
