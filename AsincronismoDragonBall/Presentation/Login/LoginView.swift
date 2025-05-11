//
//  LoginView.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 10/5/25.
//

import UIKit

final class LoginView: UIView {
    private enum Constants {
        static let textFieldHorizontalMargin: CGFloat = 50
    }
    
    
    // MARK: - UIObjects
    
    let fondoImage = {
        let backgroundImageView = UIImageView(image: UIImage(named: "FondoLogin"))
        backgroundImageView.contentMode = .scaleAspectFill
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView

    }()
    
    let emailTextfield = {
        let textfield = UITextField()
        textfield.backgroundColor = .white.withAlphaComponent(0.9)
        textfield.textColor = .black
        textfield.font = .systemFont(ofSize: 18)
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = NSLocalizedString("email", comment: "Email del usuario")
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.layer.cornerRadius = 10
        textfield.layer.masksToBounds = true //Para que se vean las esquinas redondeadas
        // Color texto del placeholder
        textfield.attributedPlaceholder = NSAttributedString(
            string: textfield.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textfield
    }()
    
    let passwordTextfield = {
        let textfield = UITextField()
        textfield.backgroundColor = .white.withAlphaComponent(0.9)
        textfield.textColor = .black
        textfield.font = .systemFont(ofSize: 18)
        textfield.borderStyle = .roundedRect
        textfield.isSecureTextEntry = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = NSLocalizedString("Password", comment: "Password del usuario")
        textfield.layer.cornerRadius = 10
        textfield.layer.masksToBounds = true //Para que se vean las esquinas redondeadas
        // Color texto del placeholder
        textfield.attributedPlaceholder = NSAttributedString(
            string: textfield.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textfield
    }()
    
    let errorLabel = {
        let errorText = UILabel()
        errorText.textColor = .white
        errorText.backgroundColor = .systemPink.withAlphaComponent(0.9)
        errorText.layer.cornerRadius = 10
        errorText.font = .systemFont(ofSize: 18)
        errorText.numberOfLines = 0
        errorText.textAlignment = .center
        errorText.isHidden = true 
        errorText.translatesAutoresizingMaskIntoConstraints = false
        
        return errorText
        
    }()
    
    let loginButton = {
        let button = UIButton(type: .system)
        button.setTitle(
            NSLocalizedString("Login", comment: "Password del usuario"),
            for: .normal
        )
        button.backgroundColor = .orange.withAlphaComponent(0.9)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constrains
    
    private func setupViews(){
        //añadimos los items de UI a la View
        
        
        //insertSubview(backgroundImageView, at: 0) // lo pone al fondo
        
        addSubview(fondoImage)
        addSubview(errorLabel)
        addSubview(emailTextfield)
        addSubview(passwordTextfield)
        addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            
            // Fondo
            fondoImage.topAnchor.constraint(equalTo: topAnchor),
            fondoImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            fondoImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            fondoImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            //user
            emailTextfield.topAnchor.constraint(equalTo: topAnchor, constant: 230),
            emailTextfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.textFieldHorizontalMargin),
            emailTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.textFieldHorizontalMargin),
            emailTextfield.heightAnchor.constraint(equalToConstant: 50),
            
            //password
            passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 40),
            passwordTextfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.textFieldHorizontalMargin),
            passwordTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.textFieldHorizontalMargin),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 50),
            
            // Mensaje de error
            
            errorLabel.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.textFieldHorizontalMargin),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.textFieldHorizontalMargin),
            errorLabel.heightAnchor.constraint(equalToConstant: 50),
            
            //boton login
            loginButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
