//
//  HeroUseCaseTest.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 9/5/25.
//

import XCTest
@testable import AsincronismoDragonBall

final class HeroUseCaseTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HeroUseCase_ReturnHero() async throws{
        // Given
        let sut = HeroUseCase(repository: HeroRepositoryMock())
        
        // When
        let expectedHeroes = await sut.getHeros(name: "Androide 17")
        let hero = try XCTUnwrap(expectedHeroes.first)
        // Then
        
        XCTAssertEqual(hero.name, "Androide 17")
        XCTAssertEqual(hero.favorite, true)
        XCTAssertEqual(hero.id, UUID(uuidString: "963CA612-716B-4D08-991E-8B1AFF625A81"))
        let expectedDesc = "Es el hermano gemelo de Androide 18. Son muy parecidos físicamente, aunque Androide 17 es un joven moreno. También está programado para destruir a Goku porque fue el responsable de exterminar el Ejército Red Ribbon. Sin embargo, mató a su creador el Dr. Gero por haberle convertido en un androide en contra de su voluntad. Es un personaje con mucha confianza en sí mismo, sarcástico y rebelde que no se deja pisotear. Ese exceso de confianza le hace cometer errores que pueden costarle la vida"
        XCTAssertEqual(hero.description, expectedDesc)
        XCTAssertEqual(hero.photo, "https://cdn.alfabetajuega.com/alfabetajuega/2019/10/dragon-ball-androide-17.jpg?width=300")
    }
    

}
