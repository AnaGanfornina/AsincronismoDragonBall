//
//  LoginError.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 11/5/25.
//

import Foundation

struct LoginError: Error , LocalizedError{
    let reason: String
    
    var errorDescription: String? {
        return reason
    }
}
