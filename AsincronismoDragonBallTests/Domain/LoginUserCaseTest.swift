//
//  LoginRepositoryTest.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 9/5/25.
//

import XCTest
@testable import AsincronismoDragonBall

final class LoginUserCaseTest: XCTestCase {
    var keychain: SecureDataProvider!

    override func setUpWithError() throws {
        try super.setUpWithError()
        keychain = SecureDataProvider()
        keychain.clearToken()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        keychain.clearToken()
        keychain = nil
    }

    func testLogin_ReturnSuccess() async throws {
        
        // Given
        
        
        keychain.setToken("LoginFackeSuccess")
        
        let sut = LoginUseCase(repository: LoginRepositoryMock())
        
        // When
        let validate = await sut.isValidateToken()
        // Login
        let login = await sut.login(user: "", password: "")
        let jwt = keychain.getToken()
        
        
        // Then
        
        XCTAssertNotNil(sut)
        XCTAssertEqual(validate, true)
        XCTAssertEqual(login,true)
        XCTAssertNotEqual(jwt, "")
  
    }
    func testLogin_CloseSession() async throws {
        // Given
        
        
        keychain.setToken("LoginFackeSuccess")
        
        let sut = LoginUseCase(repository: LoginRepositoryMock())
        let login = await sut.login(user: "", password: "")
        var jwt = keychain.getToken()
        
        // When
        
        await sut.logout()
        jwt = keychain.getToken()
        XCTAssertNil(jwt)
        
    }
}
