import XCTest
import Foundation
import UIKit
@testable import MarvelApp

class ListHQsViewModelTests: XCTestCase {
    
    var viewModel: ListHQsViewModel!
    var coordinator: MainCoordinatorMock!
    
    override func setUp() {
        super.setUp()
        coordinator = MainCoordinatorMock(navigationController: UINavigationController())
        viewModel = ListHQsViewModel(coordinator: coordinator)
    }
    
    override func tearDown() {
        viewModel = nil
        coordinator = nil
        super.tearDown()
    }
    
    var mockContentData: Data {
        return getData(name: "HQs")
    }

    func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
    
    func getHQs() -> [HQ] {
        do {
            let list: HQs = try JSONDecoder().decode(HQs.self, from: mockContentData)
            return list.data.results
        } catch {
            print(String(describing: error))
        }
        return []
    }
    
    func testGetHQs() {
        // Given
        viewModel.hqs = getHQs()
        viewModel.searchedHQs = getHQs()
        viewModel.searching = false
        
        // When
        let hqs = viewModel.getHQs()
        
        // Then
        XCTAssertEqual(hqs[0].id, 82967)
    }
    
    func testFetchFavorites() {
        // Given
        let favoriteHQs = [1, 2, 3]
        UserDefaults.standard.set(favoriteHQs, forKey: viewModel.favoriteKey)
        
        // When
        let fetchedFavorites = viewModel.fetchFavorites()
        
        // Then
        XCTAssertEqual(fetchedFavorites.count, 3)
        XCTAssertEqual(fetchedFavorites[0], 1)
        XCTAssertEqual(fetchedFavorites[1], 2)
        XCTAssertEqual(fetchedFavorites[2], 3)
    }
    
    func testUpdateFavorites_add() {
        // Given
        viewModel.hqs = getHQs()
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        viewModel.updateFavorites(indexPath: indexPath, action: .add)
        
        // Then
        XCTAssertEqual(viewModel.favoriteHQs.count, 1)
        XCTAssertEqual(viewModel.favoriteHQs[0], 1)
    }
    
    func testUpdateFavorites_remove() {
        // Given
        viewModel.hqs = getHQs()
        viewModel.favoriteHQs = [1, 2]
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        viewModel.updateFavorites(indexPath: indexPath, action: .remove)
        
        // Then
        XCTAssertEqual(viewModel.favoriteHQs.count, 1)
        XCTAssertEqual(viewModel.favoriteHQs[0], 2)
    }
    
    func testIsFavorited_true() {
        // Given
        viewModel.hqs = getHQs()
        viewModel.favoriteHQs = [1, 2]
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        let isFavorited = viewModel.isFavorited(indexPath: indexPath)
        
        // Then
        XCTAssertTrue(isFavorited)
    }
    
    func testIsFavorited_false() {
        // Given
        viewModel.hqs = getHQs()
        viewModel.favoriteHQs = [2, 3]
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        let isFavorited = viewModel.isFavorited(indexPath: indexPath)
        
        // Then
        XCTAssertFalse(isFavorited)
    }
    
    func testItemIsInCart_true() {
        // Given
        viewModel.hqs = getHQs()
        coordinator.cartManager.addItem(item: viewModel.hqs[0])
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        let itemIsInCart = viewModel.itemIsInCart(indexPath: indexPath)
        
        // Then
        XCTAssertTrue(itemIsInCart)
    }
    
    func testItemIsInCart_false() {
        // Given
        viewModel.hqs = getHQs()
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        let itemIsInCart = viewModel.itemIsInCart(indexPath: indexPath)
        
        // Then
        XCTAssertFalse(itemIsInCart)
    }
    
    func testOpenDetail() {
        // Given
        viewModel.hqs = getHQs()
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        viewModel.openDetail(indexPath: indexPath)
        
        // Then
        XCTAssertTrue(coordinator.openHQDetailCalled)
        XCTAssertEqual(coordinator.openedHQ?.id, 1)
    }
    
    func testNextPage() {
        // Given
        viewModel.offset = 0
        viewModel.limit = 10
        
        // When
        viewModel.nextPage()
        
        // Then
        XCTAssertEqual(viewModel.offset, 10)
        XCTAssertEqual(viewModel.limit, 20)
    }
    
    func testPreviusPage() {
        // Given
        viewModel.offset = 10
        viewModel.limit = 20
        
        // When
        viewModel.previusPage()
        
        // Then
        XCTAssertEqual(viewModel.offset, 0)
        XCTAssertEqual(viewModel.limit, 10)
    }
}

class MainCoordinatorMock: MainCoordinator {
    
    var openHQDetailCalled = false
    var openedHQ: HQ?
    
    override func openHQDetail(hq: HQ) {
        openHQDetailCalled = true
        openedHQ = hq
    }
}

class CartManagerMock: CartManager {
    
    var addItemCalled = false
    var addedItem: HQ?
    
    override func addItem(item: HQ) {
        addItemCalled = true
        addedItem = item
    }
    
    var removeItemCalled = false
    var removedItemId: Int?
    
    override func removeItem(id: Int) {
        removeItemCalled = true
        removedItemId = id
    }
}
