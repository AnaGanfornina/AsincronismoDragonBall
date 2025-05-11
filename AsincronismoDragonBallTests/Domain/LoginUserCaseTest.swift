//
//  LoginRepositoryTest.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 9/5/25.
//

import XCTest
@testable import AsincronismoDragonBall

final class LoginUserCaseTest: XCTestCase {
    var testKeychain: MockSecureDataProvider!

    override func setUpWithError() throws {
        try super.setUpWithError()
        testKeychain = MockSecureDataProvider()
        testKeychain.clearToken()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        testKeychain.clearToken()
        testKeychain = nil
    }

    func testLogin_ReturnSuccess() async throws {
        
        // Given
        testKeychain.setToken("LoginFackeSuccess")
        
        let sut = LoginUseCase(repository: LoginRepositoryMock())
        
        // When
        let validate = await sut.isValidateToken()
        // Login
        let login = try await sut.login(user: "", password: "")
        let jwt = testKeychain.getToken()
        
        
        // Then
        
        XCTAssertNotNil(sut)
        XCTAssertEqual(validate, true)
        XCTAssertEqual(login,true)
        XCTAssertNotEqual(jwt, "")
  
    }
    func testLogin_CloseSession() async throws {
        // Given
        
        
        testKeychain.setToken("LoginFackeSuccess")
        
        let sut = LoginUseCase(repository: LoginRepositoryMock())
        sut.keychain = testKeychain
        //let login = await sut.login(user: "", password: "")
        var jwt = testKeychain.getToken()
        
        // When
        
        await sut.logout()
        jwt = testKeychain.getToken()
        
        // Then
        XCTAssertNil(jwt)
        
    }
}
