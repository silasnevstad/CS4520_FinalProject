//
//  CreateMovieViewController.swift
//  ArtHaus
//
//  Created by user241517 on 6/20/23.
//

import UIKit
import FirebaseAuth

class CreateMovieViewController: UIViewController, UINavigationControllerDelegate {
    var createMovieView: CreateMovieView!
    var selectedCoverImage: UIImage?
    
    override func loadView() {
        createMovieView = CreateMovieView()
        view = createMovieView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Idea"
        createMovieView.coverImageButton.addTarget(self, action: #selector(handleCoverImagePick), for: .touchUpInside)
        createMovieView.postButton.addTarget(self, action: #selector(handlePost), for: .touchUpInside)
    }
    
    @objc func handleCoverImagePick() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }

    @objc func handlePost() {
        guard let title = createMovieView.titleField.text,
              let description = createMovieView.descriptionField.text,
              let coverImage = selectedCoverImage else {
            showAlert(title: "Missing Information", message: "Please make sure all fields are filled and a cover image is selected.")
            return
        }
        
        // Firstly, we will upload the cover image
        APIConfigs.shared.uploadImage(image: coverImage) { [weak self] result in
            switch result {
            case .success(let imageUrl):
                // After the image has been uploaded, we will post the movie idea
                APIConfigs.shared.postMovieIdea(title: title, description: description, coverImageUrl: imageUrl) { result in
                    switch result {
                    case .success:
                        print("Successfully posted movie idea")
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print("Failed to post movie idea: \(error)")
                    }
                }
            case .failure(let error):
                print("Failed to upload image: \(error)")
            }
        }
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// Image picker delegation methods
extension CreateMovieViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            selectedCoverImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedCoverImage = originalImage
        }

        createMovieView.coverImageView.image = selectedCoverImage

        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
