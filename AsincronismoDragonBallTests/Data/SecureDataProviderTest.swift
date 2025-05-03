//
//  SecureDataProviderTest.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 3/5/25.
//

import XCTest
@testable import AsincronismoDragonBall

final class SecureDataProviderTest: XCTestCase {
    
    private var sut: SecureDataProvider!
    private var token: String? = ""

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SecureDataProvider()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut.clearToken()
        sut = nil
        
       
    }
    
    func test_GetToken_ReturnTokenExpected() {
        
        // Given
        token = "PruebaToken"
        sut.setToken(token!)
        
        
        // When
        guard let expectedToken = sut.getToken() else {
            XCTFail("Expect a value not nil")
            return
        }
        
        // Then
        
        XCTAssertEqual(token, expectedToken)
    }
    
    func test_SetToken_ReturnChangedToken() {
        
        // Given
        token = sut.getToken()

        // When
        sut.setToken("NewToken")
        guard let newToken = sut.getToken() else {
            XCTFail("Expect another value")
            return
        }

        // Then
        
        XCTAssertNotNil(newToken)
        XCTAssertEqual(newToken, token)
        XCTAssertEqual("NewToken", newToken)
        
    }
    
    func test_ClearToken_ReturnNil() {
        
        // Given
        sut.setToken("PruebaToken")
        token = sut.getToken()

        // When
        sut.clearToken()
        token = sut.getToken()
        

        // Then
        
        XCTAssertNil(token)
      
        
    }
    


}
