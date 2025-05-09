//
//  LoginRepositoryTest.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 9/5/25.
//

import XCTest
@testable import AsincronismoDragonBall

final class LoginRepositoryTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_loginRepository() async throws{
        // Given
        let mock = ApiProviderMock()
        let tokenMock = await mock.login(username: "PruebaUser", password: "PruebaPass")
        
        let sut = LoginRepository(network: mock)
        
        // When
        let token = await sut.loginApp(user: "PruebaUser", pass: "PruebaPass")
        
        // Then
        XCTAssertEqual(token, tokenMock)
        
    }

}
