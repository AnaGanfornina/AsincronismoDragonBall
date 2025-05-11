//
//  HeroListPresentationTest.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 11/5/25.
//

import XCTest
@testable import AsincronismoDragonBall
import Combine

final class HeroListPresentationTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testHerosUseCase() async throws  {
        let sut = HeroUseCase(repository: HeroRepositoryMock())
        XCTAssertNotNil(sut)
        
        let data = await sut.getHeros(name: "")
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 15)
    }
    /*
    func testHeroiewViewModel() async throws  {
        let sut = HeroListViewModel(useCase: HeroUseCaseMock())
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.heros.count, 14)
    }
     */
    func testHeros_Presentation() async throws  {
        let viewModel = HeroListViewModel(useCase: HeroUseCaseMock())
        XCTAssertNotNil(viewModel)
        
        let view =  await HeroListViewController(appState: AppState(loginUseCase: LoginUseCaseSuccesMock()), viewModel: viewModel)
        XCTAssertNotNil(view)
        
    }
  /*
    func testHeros_Combine() async throws  {
        var suscriptor = Set<AnyCancellable>()
        let exp = self.expectation(description: "Heros get")
        let vm = HeroListViewModel(useCase: HeroUseCaseMock())
        await vm.loadHeros()
        XCTAssertNotNil(vm)
        
        vm.$heros
            .sink { completion in
                switch completion{
                    
                case .finished:
                    print("finalizado")
                }
            } receiveValue: { data in
      
                if data.count == 2 {
                    exp.fulfill()
                }
            }
            .store(in: &suscriptor)
      
        
        
        //await self.waitForExpectations(timeout: 2)
    }
    
    func testLoadData() async {
        // Given
        var expectedHeroes: [Hero] = []
        let sut = HeroListViewModel(useCase: HeroUseCaseMock())
       
        
        
        // When
        await sut.loadHeros()
        
        sut.$heros
            .sink { hero in
                expectedHeroes = hero
            }
        
        // Then
   
        XCTAssertEqual(expectedHeroes.count, 15)
    }
    
    func test_HeroListViewController(){
        // Given
        let mockHero = Hero(id: UUID(), favorite: true, description: "Prueba", photo: "Photo", name: "Goku")
        let viewModel = HeroListViewModel()
        let appState = AppState()
        let sut = HeroListViewController(appState: appState, viewModel: viewModel)
        sut.loadViewIfNeeded()
        
        // When
        
        viewModel.heros = [mockHero]
        
        let numberOfItems = sut.collectionView.numberOfItems(inSection: 0)
        
       
        
        // Then
        
        XCTAssertEqual(numberOfItems, 1)
        
        
        
    }
    
    */
    func  test_ViewModelBinding_UpdatesCollectionView(){
        
        // Given
        let mockUseCase = HeroUseCaseMock()
        let viewModel = HeroListViewModel(useCase: mockUseCase)
        let sut = HeroListViewController(appState: AppState(), viewModel: viewModel)
        
        
        // When
        
        sut.loadViewIfNeeded()
        
    
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        let numberOfItems = sut.collectionView.numberOfItems(inSection: 0)
        
        // Then
        
        XCTAssertEqual(numberOfItems, 15)
                    
    }
    
    func test_HeroListBuilderSucces(){
        // Given
        
        let sut = HeroesListBuilder()
        
        // When
        
        let controller = sut.build()
        
        // Then
        
        XCTAssertTrue(controller is UINavigationController)
        let navController = controller as? UINavigationController
        let rootViewController = navController?.viewControllers.first

        XCTAssertTrue(rootViewController is HeroListViewController)
        XCTAssertEqual(controller.modalPresentationStyle, .fullScreen)
    }
    

}
