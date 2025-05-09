//
//  LoginUseCaseMock.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 9/5/25.
//

import Foundation
@testable import AsincronismoDragonBall

final class LoginUseCaseSuccesMock: LoginUseCaseProtocol {
    var repository: any LoginRepositoryProtocol
    let secureData = SecureDataProvider()
    
    
    init(repository: any LoginRepositoryProtocol = LoginRepositoryMock()) {
        self.repository = repository
    }
    
    func login(user: String, password: String) async -> Bool {
        let token = await repository.loginApp(user: user, pass: password)
        
        secureData.setToken("LoginFackeSuccess")
        return true
    }
    
    func logout() async {
        secureData.clearToken()
    }
    
    func isValidateToken() async -> Bool {
        return true
    }
    
    
    
    
}
