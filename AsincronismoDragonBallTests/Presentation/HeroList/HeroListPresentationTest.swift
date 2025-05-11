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
      
        await vm.loadHeros()
        await self.waitForExpectations(timeout: 2)
    }
*/
}
