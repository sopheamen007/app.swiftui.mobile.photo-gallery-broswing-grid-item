//
//  UploadView.swift
//  Youtube_PhotosGallery
//
//  Created by Sopheamen VAN on 16/7/24.
//
import SwiftUI

struct UploadView: View {
    var displayImage: UIImage?
    // back button trigger
    @Environment(\.dismiss) var dismiss
    @State private var textFieldCaption = ""
    @State private var isOnFacebook = false
    var body: some View {
        NavigationStack {
            VStack {
                //
                HStack (alignment: .top) {
                    // replace with actual image from photo gallery page
                    if let image = displayImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 65, height: 80)
                            .clipped()
                    }else {
                        Rectangle()
                            .fill(Color.primaryColor)
                            .frame(width: 65, height: 80)
                    }
                    
                    Spacer()
                    
                    // textfield caption here
                    TextField("Write a caption", text: $textFieldCaption)
                    
                }
                .padding()
                
                //
              
                
                VStack (spacing: 14){
                    Divider()
                        .background(.white)
                    HStack {
                        Text("Tag people")
                            .font(.subheadline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                    Divider()
                        .background(.white)
                    HStack {
                        Text("Add location")
                            .font(.subheadline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                    Divider()
                        .background(.white)
                    HStack {
                        Text("Facebook")
                            .font(.subheadline)
                        Spacer()
                        Toggle(isOn: $isOnFacebook) {
                            
                        }
                    }
                    .padding(.horizontal)
                }
                // break space
                Spacer()
                
            }
            .navigationTitle("New post")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // leading icon
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.white)
                    }
                }
                // trailing icon
                ToolbarItem (placement: .topBarTrailing){
                    Button {
                        
                    }label: {
                        Text("Share")
                            .font(.headline)
                            .foregroundStyle(Color.primaryColor)
                    }
                }
            }
        }
        .colorScheme(.dark)
    }
}

#Preview {
    UploadView()
}
