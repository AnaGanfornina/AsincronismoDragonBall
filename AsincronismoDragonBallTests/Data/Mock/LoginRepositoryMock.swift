//
//  LoginRepositoryMock.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 9/5/25.
//

import Foundation
@testable import AsincronismoDragonBall

final class LoginRepositoryMock: LoginRepositoryProtocol {
    
    private var network: ApiProviderProtocol
    
    init(network: ApiProviderProtocol = ApiProviderMock()) {
        self.network = network
    }
    func loginApp(user: String, pass: String) async -> String {
        return await network.login(username: user, password: pass)
    }
}
