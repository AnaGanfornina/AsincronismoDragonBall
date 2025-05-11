//
//  ApiProviderTest.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 4/5/25.
//

import XCTest
@testable import AsincronismoDragonBall

final class ApiProviderTest: XCTestCase {
    
    var sut: ApiProvider!
    var secureData: SecureDataProtocol!
    let expectedToken = "token"

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Creamos la URLSession usando nuestro Mock de URLProtocol en la configuración
        
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        // Creamos ApiProvider con usando nuestra session en el constructor
        secureData = MockSecureDataProvider()
        let requestBuilder = RequestBuilder(secureData: secureData)
        sut = ApiProvider(session: session, requestBuilder: requestBuilder)
        secureData.setToken(expectedToken)
        
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
            MockURLProtocol.requestHandler = nil
            MockURLProtocol.error = nil
            secureData.clearToken()
            sut = nil
        
    }
    
    func test_getHeroes() async throws {
        // Given
        
        var expectedHeroes: [HeroDTO] = []
        
        // Inicializamos el MockURLProtocol
        var receivedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            // Guardamos en una variable la request que no devuelve el mock para validaciones posteriores.
            receivedRequest = request
            
            // Creamos Data que recibiría la app en el dataTask
            let urlData = try XCTUnwrap(Bundle(for: ApiProviderTest.self).url(forResource: "Heroes", withExtension: "json"))
            
           
            let data = try Data(contentsOf: urlData)
            
            // Creamos el response que recibiría la app en el dataTask
            let urlRequest = try XCTUnwrap(request.url)
            let response = try XCTUnwrap(MockURLProtocol.httpResponse(url: urlRequest, statusCode: 200))
            
            return (response, data)
        }
        
        // When
        
        expectedHeroes = await sut.getHeros()
       
        // Then
        
        // Validamos la info del a request
        
        XCTAssertEqual(receivedRequest?.url?.absoluteString, "https://dragonball.keepcoding.education/api/heros/all")
        XCTAssertEqual(receivedRequest?.httpMethod, "POST")
        XCTAssertEqual(receivedRequest?.value(forHTTPHeaderField: "Content-Type"), "application/json, charset=utf-8")
        XCTAssertEqual(receivedRequest?.value(forHTTPHeaderField: "Authorization"), "Bearer \(expectedToken)")
        
        // Validamos la información recibida de la función
        XCTAssertEqual(expectedHeroes.count, 15)
        let hero = try XCTUnwrap(expectedHeroes.first)
        
        XCTAssertEqual(hero.name, "Maestro Roshi")
        XCTAssertEqual(hero.id, "14BB8E98-6586-4EA7-B4D7-35D6A63F5AA3")
        XCTAssertEqual(hero.photo, "https://cdn.alfabetajuega.com/alfabetajuega/2020/06/Roshi.jpg?width=300")
        XCTAssertEqual(hero.favorite, false)
        let expectedDesc = "Es un maestro de artes marciales que tiene una escuela, donde entrenará a Goku y Krilin para los Torneos de Artes Marciales. Aún en los primeros episodios había un toque de tradición y disciplina, muy bien representada por el maestro. Pero Muten Roshi es un anciano extremadamente pervertido con las chicas jóvenes, una actitud que se utilizaba en escenas divertidas en los años 80. En su faceta de experto en artes marciales, fue quien le enseñó a Goku técnicas como el Kame Hame Ha"
        XCTAssertEqual(hero.description, expectedDesc)
        
    }
    func test_getTransformation() async throws{
        // Given
        var expectedTransformations: [TransformationDTO] = []
        
        var recivedRequest: URLRequest?
        
        MockURLProtocol.requestHandler = { request in
            
            recivedRequest = request
            
            let urlData = try XCTUnwrap(Bundle(for: ApiProviderTest.self).url(forResource: "Transformations", withExtension: "json"))
            let data = try Data(contentsOf: urlData)
            
            let urlRequest = try XCTUnwrap(request.url)
            let response = try XCTUnwrap(MockURLProtocol.httpResponse(url: urlRequest, statusCode: 200))
            
            return (response, data)
        }
        // When
        
        expectedTransformations = await sut.getTransformation()
        
        // Then
        
        // Validamos la info del request
        
        XCTAssertEqual(recivedRequest?.url?.absoluteString, "https://dragonball.keepcoding.education/api/heros/tranformations")
        XCTAssertEqual(recivedRequest?.httpMethod, "POST")
        XCTAssertEqual(recivedRequest?.value(forHTTPHeaderField: "Content-Type"), "application/json, charset=utf-8")
        XCTAssertEqual(recivedRequest?.value(forHTTPHeaderField: "Authorization"), "Bearer \(expectedToken)")
        
        // Validamos la información recibida de la función

        XCTAssertEqual(expectedTransformations.count, 14)
        
        let transformaton = try XCTUnwrap(expectedTransformations.first)
        
        XCTAssertEqual(transformaton.name, "1. Oozaru – Gran Mono")
        
        let description = "Cómo todos los Saiyans con cola, Goku es capaz de convertirse en un mono gigante si mira fijamente a la luna llena. Así es como Goku cuando era un infante liberaba todo su potencial a cambio de perder todo el raciocinio y transformarse en una auténtica bestia. Es por ello que sus amigos optan por cortarle la cola para que no ocurran desgracias, ya que Goku mató a su propio abuelo adoptivo Son Gohan estando en este estado. Después de beber el Agua Ultra Divina, Goku liberó todo su potencial sin necesidad de volver a convertirse en Oozaru"
        
        XCTAssertEqual(transformaton.description, description)
        XCTAssertEqual(transformaton.id, "17824501-1106-4815-BC7A-BFDCCEE43CC9")
        XCTAssertEqual(transformaton.photo, "https://areajugones.sport.es/wp-content/uploads/2021/05/ozarru.jpg.webp")
        XCTAssertEqual(transformaton.hero.id, "D13A40E5-4418-4223-9CE6-D2F9A28EBE94")
    }
    
    func test_login_success() async throws {
        // Given
        
        var expectedTokenString = ""
        var loginString = ""
        let username = "PruebaUsername"
        let password = "PruebaPassword"
        
        // Codificamos el usuario y contraseña
        
        let loginStringFormat = String(format: "%@:%@", username, password)
        let loginData = loginStringFormat.data(using: .utf8)!
        loginString = loginData.base64EncodedString()
        
        var receivedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            
            receivedRequest = request
            
            let data = self.expectedToken.data(using: .utf8)!
            
            // Creamos el response que recibiría la app en el dataTask
            let urlRequest = try XCTUnwrap(request.url)
            let response = try XCTUnwrap(MockURLProtocol.httpResponse(url: urlRequest, statusCode: 200))
            
            return (response,data)
        }
        
        
        
        // When
        
        expectedTokenString = try await sut.login(username: username, password: password)
        
        // Then
        
        // Validamos la info del a request
        XCTAssertEqual(receivedRequest?.url?.absoluteString, "https://dragonball.keepcoding.education/api/auth/login")
        XCTAssertEqual(receivedRequest?.httpMethod, "POST")
        XCTAssertEqual(receivedRequest?.value(forHTTPHeaderField: "Content-Type"), "application/json, charset=utf-8")
        let expectedAuthHeader = "Basic \(loginString)"
        XCTAssertEqual(receivedRequest?.value(forHTTPHeaderField: "Authorization"), expectedAuthHeader)
        
        // Validamos la información recibida de la función
        
        XCTAssertEqual(expectedToken, expectedTokenString)
    }

}



// Given

// When

// Then
