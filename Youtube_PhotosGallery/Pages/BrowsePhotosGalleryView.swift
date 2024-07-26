//
//  BrowsePhotosGalleryView.swift
//  Youtube_PhotosGallery
//
//  Created by Sopheamen VAN on 16/7/24.
//

import SwiftUI
import Photos

struct BrowsePhotosGalleryView: View {
    // get size of the screen
    let height = ((UIScreen.main.bounds.height - 140) / 2)
    
    // design grid as 3 items
    let columns:[GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    let size = ((UIScreen.main.bounds.width) / 3) - 2
    
    // dummy items
    let photosItem = [
    "1","2", "3",
    "4","5", "6"
    ]
    
    // post floating buttons
    let floatingButtons = [
        "POST", "STORY" , "REEL" , "LIVE"
    ]
    
    // images
    @State private var selectedImages:[UIImage] = []
    @State private var displayImage: UIImage?
    
    var body: some View {
        NavigationStack {
            VStack {
                // content here
                if  selectedImages.isEmpty {
                    Text("No images selected")
                        .onAppear(perform: loadImages)
                } else {
                    VStack {
                       // main image
                       Image(uiImage: displayImage ?? selectedImages[0])
                           .resizable()
                           .scaledToFit()
                           .frame(height: height)
                       
                       // select option section
                       SelectionMultiplesView()
                       
                       // break space
                       Spacer()
                       
                       // photo collection
                       ZStack (alignment: .bottomTrailing){
                           ScrollView (showsIndicators: false){
                               LazyVGrid (columns: columns, spacing: 2){
                                   // photo collection view
                                   ForEach(selectedImages, id: \.self) { image in
                                       Button {
                                           displayImage = image
                                           
                                       }label: {
                                           Image(uiImage: image)
                                               .resizable()
                                               .scaledToFill()
                                               .frame(width: size, height: size)
                                               .clipped()
   //
                                       }
                                   }
                               }
                           }
                           
                           // post floating buttons
                           HStack (spacing: 12){
                               ForEach(floatingButtons, id: \.self) { item in
                                   Text(item)
                                       .font(.subheadline)
                                       .foregroundStyle(.white)
                               }
                           }
                           .padding(.vertical ,10)
                           .padding(.horizontal, 20)
                           .background(.gray)
                           .clipShape(RoundedRectangle(cornerRadius: 30))
                           .padding()
                       }
                   }
                }
                
                
            }
            .navigationBarTitle("New Post", displayMode: .inline)
            .toolbar (){
                // leading icon
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        
                    }label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                    }
                }
                // trailling icon
                ToolbarItem (placement: .topBarTrailing){
                    NavigationLink (destination: UploadView(displayImage: displayImage)) {
                        Text("Next")
                            .font(.headline)
                            .foregroundStyle(Color.primaryColor)
                    }
                   
                }
            }
        }
        // to dark theme
        .colorScheme(.dark)
    }
    
    // two functions to load the actual photos from gallery
    
    // load images
    private func loadImages(){
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    self.fetchImages()
                }
            }
        }else if status == .authorized {
            self.fetchImages()
        }
    }
    
    // fetch images api
    private func fetchImages(){
        // fetch the images from photo library
        let fetchOptions = PHFetchOptions()
        // sort by creation Date
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        // get 24 photos
        fetchOptions.fetchLimit = 24
        // get images
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        let imageManager = PHCachingImageManager()
        fetchResult.enumerateObjects { asset, _, _ in
            let targetSize = CGSize(width: 300, height: 300)
            let options = PHImageRequestOptions()
            options.isSynchronous = false
            options.deliveryMode = .highQualityFormat
            
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options ) { image, _ in
                if let image = image {
                    DispatchQueue.main.async {
                        // pass images to states and render
                        self.selectedImages.append(image)
                    }
                }
            }
        }
    }
    
    
}



#Preview {
    BrowsePhotosGalleryView()
}

struct SelectionMultiplesView:View {
    var body: some View {
        HStack {
            HStack (spacing: 7){
                Text("Recents")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                Image(systemName: "chevron.down")
                
            }
            
            //break space
            Spacer()
            
            // selected multiple option button
            HStack (spacing: 10){
                HStack {
                    Image("photo_collection_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                    Text("Select multiple")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                .padding(.vertical, 6)
                .padding(.horizontal,12)
                .background(.white.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // camera icon
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(.all, 8)
                    .background(.white.opacity(0.15))
                    .clipShape(Circle())
            }
            
           
            
        }
        .padding(.horizontal)
        .frame(minHeight: 35)
    }
}

