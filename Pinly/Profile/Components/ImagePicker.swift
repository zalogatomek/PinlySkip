//
//  ImagePicker.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 01/02/2025.
//

import SwiftUI
import PhotosUI

struct ImagePicker: View {
    @Binding var selectedImage: UIImage?
    @Binding var shouldRemoveAvatar: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var showingCamera = false
    @State private var showingPhotoLibrary = false
    let hasExistingImage: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Button(action: {
                showingPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "photo.on.rectangle")
                        .frame(width: 24)
                    Text("Choose from Library")
                    Spacer()
                }
                .padding(.horizontal)
                .frame(height: 44)
            }
            
            Button(action: {
                showingCamera = true
            }) {
                HStack {
                    Image(systemName: "camera")
                        .frame(width: 24)
                    Text("Take Photo")
                    Spacer()
                }
                .padding(.horizontal)
                .frame(height: 44)
            }
            
            if hasExistingImage {
                Button(action: {
                    selectedImage = nil
                    shouldRemoveAvatar = true
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "trash")
                            .frame(width: 24)
                        Text("Remove Current Picture")
                        Spacer()
                    }
                    .foregroundStyle(.red)
                    .padding(.horizontal)
                    .frame(height: 44)
                }
            }
        }
        .padding()
        .padding(.top, 12)
        .foregroundStyle(.primary)
        .background(Color(.systemBackground))
        .sheet(isPresented: $showingCamera) {
            CameraView(selectedImage: $selectedImage, isPresented: $showingCamera)
        }
        .sheet(isPresented: $showingPhotoLibrary) {
            PhotoPicker(selectedImage: $selectedImage, isPresented: $showingPhotoLibrary)
        }
    }
}

struct CameraView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.isPresented = false
        }
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.isPresented = false
            
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.selectedImage = image as? UIImage
                    }
                }
            }
        }
    }
}
