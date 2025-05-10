//
//  HeroTransformationUseCaseTest.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 10/5/25.
//

import XCTest
@testable import AsincronismoDragonBall

final class HeroTransformationUseCaseTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func test_HeroUseCase_ReturnTransformation() async throws {
        // Given
        let sut = HeroTransformationUseCase(repository: HeroTransformationRepositoryMock())
        
        // When
        
        let expectedTransformations = await sut.getTransformation(id: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94")
        let transformation = try XCTUnwrap(expectedTransformations.first)
        
        
        
        
        // Then
        XCTAssertEqual(expectedTransformations.count, 14)
        
        XCTAssertEqual(transformation.name, "1. Oozaru – Gran Mono")
        let expectedDescription = "Cómo todos los Saiyans con cola, Goku es capaz de convertirse en un mono gigante si mira fijamente a la luna llena. Así es como Goku cuando era un infante liberaba todo su potencial a cambio de perder todo el raciocinio y transformarse en una auténtica bestia. Es por ello que sus amigos optan por cortarle la cola para que no ocurran desgracias, ya que Goku mató a su propio abuelo adoptivo Son Gohan estando en este estado. Después de beber el Agua Ultra Divina, Goku liberó todo su potencial sin necesidad de volver a convertirse en Oozaru"
        XCTAssertEqual(transformation.description, expectedDescription)
        let expectedId = String(describing: transformation.id)
        XCTAssertEqual(expectedId,"17824501-1106-4815-BC7A-BFDCCEE43CC9")
        XCTAssertEqual(transformation.photo,"https://areajugones.sport.es/wp-content/uploads/2021/05/ozarru.jpg.webp")
        let expectedHeroId = String(describing: transformation.hero.id)
        XCTAssertEqual(expectedHeroId, "D13A40E5-4418-4223-9CE6-D2F9A28EBE94")
    }

}

