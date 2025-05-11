//
//  HeroDetailTest.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 11/5/25.
//

import XCTest
@testable import AsincronismoDragonBall


final class HeroDetailTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HeroListBuilderSucces(){
        // Given
        let hero = Hero(id: UUID(), favorite: true, description: "Prueba", photo: "Photo", name: "Goku")
        let sut = HeroDetailBuilder(hero: hero)
        
        // When
        
        let viewController = sut.build()
        
        // Then
        
        XCTAssertTrue(viewController is HeroDetailViewController)
           
       let detailVC = viewController as? HeroDetailViewController
        XCTAssertEqual(detailVC?.testViewModel.hero?.name, hero.name)
    }

}
