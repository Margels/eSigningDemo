//
//  ViewController.swift
//  eSigningDemo
//
//  Created by Margels on 11/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var containerStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 16
        sv.distribution = .fill
        return sv
    }()
    
    private lazy var signHereLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Sign Here ⬇️"
        l.textAlignment = .center
        return l
    }()
    
    private lazy var signatureView: SignatureView = {
        let v = SignatureView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 12
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.gray.cgColor
        v.onBeginDrawing = { self.handleMainButton(isEnabled: true) }
        return v
    }()
    
    private lazy var createTemplateButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Create Template", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .systemBlue
        b.layer.cornerRadius = 8
        return b
    }()

    private lazy var clearTemplateButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Clear", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        b.setTitleColor(.systemBlue, for: .normal)
        b.layer.cornerRadius = 4
        b.addTarget(self, action: #selector(didTapClear), for: .touchUpInside)
        return b
    }()
    
    let apiKey = "9ad148f660886717f5b61e5d56299ac6acb71f53f7d384e5c1c6c9b2ed4004a9"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpView()
        self.setUpConstraints()
        self.handleMainButton(isEnabled: false)
    }
    
    private func setUpView() {
        
        self.view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(signHereLabel)
        containerStackView.addArrangedSubview(signatureView)
        containerStackView.addArrangedSubview(createTemplateButton)
        containerStackView.addArrangedSubview(clearTemplateButton)
        
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
        
            containerStackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor, constant: 50),
            signatureView.heightAnchor.constraint(equalToConstant: 200),
            createTemplateButton.heightAnchor.constraint(equalToConstant: 50),
            clearTemplateButton.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
    }
    
    private func handleMainButton(isEnabled: Bool) {
        createTemplateButton.isUserInteractionEnabled = isEnabled
        createTemplateButton.alpha = isEnabled ? 1 : 0.5
    }

    @objc private func didTapCreateTemplate() {
        
    }
    
    @objc private func didTapClear() {
        self.handleMainButton(isEnabled: false)
        self.signatureView.clear()
    }

}

