//
//  LoginPresentationTest.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 11/5/25.
//

import XCTest
@testable import AsincronismoDragonBall

final class LoginPresentationTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUILoginView()  throws  {
        XCTAssertNoThrow(LoginView())
        let sut = LoginView()
        XCTAssertNotNil(sut)
        
       
        let txtUser = sut.emailTextfield
        XCTAssertNotNil(txtUser)
        let txtPass = sut.passwordTextfield
        XCTAssertNotNil(txtPass)
        let button = sut.loginButton
        XCTAssertNotNil(button)
        
        //Ojo, aqui hay que testear con la variable localizada
        XCTAssertEqual(txtUser.placeholder, NSLocalizedString("email", comment: ""))
        XCTAssertEqual(txtPass.placeholder, NSLocalizedString("password", comment: ""))
        XCTAssertEqual(button.titleLabel?.text, NSLocalizedString("login", comment: ""))
        
        
        //la vista esta generada
        let View2 =  LoginViewController(appState: AppState(loginUseCase: LoginUseCaseSuccesMock()))
       XCTAssertNotNil(View2)
        XCTAssertNoThrow(View2.loadView()) //generamos la vista
        XCTAssertNotNil(View2.loginButton)
        XCTAssertNotNil(View2.emailTextfield)
        XCTAssertNotNil(View2.passwordTexfield)
        
        //el binding
        XCTAssertNoThrow(View2.bindUI())
        
        View2.emailTextfield?.text = "Hola"
        
        //el boton debe estar desactivado
        XCTAssertEqual(View2.emailTextfield?.text, "Hola")
    }
}
