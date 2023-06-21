//
//  CreateMovieView.swift
//  ArtHaus
//
//  Created by user241517 on 6/20/23.
//

import UIKit

class CreateMovieView: UIView {
    
    let titleField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Title"
        tf.borderStyle = .none
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.systemGray5.cgColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.layer.cornerRadius = 12
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()

    let descriptionField: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 20)
        tv.layer.cornerRadius = 12
        tv.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tv.layer.borderWidth = 2.0
        tv.layer.borderColor = UIColor.systemGray5.cgColor
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.image = UIImage(systemName: "questionmark.square.dashed")
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let coverImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pick Cover Image", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 10, right: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post Movie Idea", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.layer.cornerRadius = 12.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(titleField)
        addSubview(descriptionField)
        addSubview(coverImageView)
        addSubview(coverImageButton)
        addSubview(postButton)

        let padding: CGFloat = 20
        let buttonHeight: CGFloat = 50
        let textFieldHeight: CGFloat = 60
        let textViewHeight: CGFloat = 120

        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            titleField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleField.heightAnchor.constraint(equalToConstant: textFieldHeight),

            descriptionField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: padding),
            descriptionField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            descriptionField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            descriptionField.heightAnchor.constraint(equalToConstant: textViewHeight),
            
            coverImageView.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: padding),
            coverImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            coverImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor),

            coverImageButton.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: padding),
            coverImageButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            postButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            postButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            postButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            postButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
