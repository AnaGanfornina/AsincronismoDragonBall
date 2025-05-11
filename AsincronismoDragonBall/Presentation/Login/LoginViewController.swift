//
//  LoginViewController.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 10/5/25.
//

import UIKit
import Combine
import CombineCocoa

final class LoginViewController: UIViewController {
    
    
    private var appState: AppState?
    var suscriptions = Set<AnyCancellable>()
    
    private var password: String = ""
    private var user: String = ""

    
    // MARK: - UIObjects
    
    var loginButton: UIButton!
    var emailTextfield: UITextField!
    var passwordTexfield: UITextField!
    var errorLabel: UILabel!
    
    
    // MARK: - Initializer
    
    init(appState: AppState) {
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
        
    }
    
    override func loadView() {
        super.loadView()
        //Instancion la clase que va a generar la UI
        
        let loginView = LoginView()
        
        //Asigno las 2 cajas y el boton
        emailTextfield = loginView.emailTextfield
        passwordTexfield = loginView.passwordTextfield
        errorLabel = loginView.errorLabel
        loginButton = loginView.loginButton
        view = loginView
        

    }
    
    // MARK: - Binding
    
    private func bind() {
        appState?.$loginStatus
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
                switch state {
                case .error(let reason):
                    self?.renderError(reason)
                case .loading:
                    self?.renderLoading()
                case .success:
                    self?.renderSuccess()
                case .notValidated:
                    self?.renderLoading()
                }
            }).store(in: &suscriptions)
    }
    
    func bindUI() {
        suscribeUserText()
        suscribePassword()
        suscribeButton()
    }
    //Suscriptions
    
    private func suscribeUserText() {
        self.emailTextfield.textPublisher
            .receive(on: DispatchQueue.main)
            .debounce(for: .seconds(0.8), scheduler: RunLoop.main)
            .compactMap{$0}
            .sink { [weak self] userText in
                print("User: \(userText)")
                self?.user = userText
                self?.enableButtonIfNeeded(userText)
            }
            .store(in: &suscriptions)
    }
    
    private func suscribePassword() {
        self.passwordTexfield.textPublisher
            .receive(on: DispatchQueue.main)
            .debounce(for: .seconds(0.8), scheduler: RunLoop.main)
            .sink { [weak self] password in
                if let password {
                    print("Password: \(password)")
                    self?.password = password
                }
            }
            .store(in: &suscriptions)
    }
    
    private func suscribeButton() {
        self.loginButton.tapPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                if let user = self?.user,
                   let pass = self?.password,
                   pass.count > 0 {
                    self?.appState?.loginApp(user: user, pass: pass)
                } else {
                    print("No hacer nada")
                }
            }
            .store(in: &suscriptions)
    }
    
    
    // Validation
    
    private func enableButtonIfNeeded(_ userText: String) {
        self.loginButton.isEnabled = userText.count >= 5
    }
    
    // MARK: - Stage management
    
    private func renderSuccess() {
        print("vamos al HeroList")
        errorLabel.isHidden = true
        present(HeroesListBuilder().build(), animated: true)
    }
    private func renderLoading() {
        bindUI()
        errorLabel.isHidden = true
        loginButton.isEnabled = false
        emailTextfield.becomeFirstResponder() //Para que se enfoque nada mas entrar
    }
    private func renderError(_ message: String){
        errorLabel.isHidden = false
        errorLabel.text = message
    }
}
