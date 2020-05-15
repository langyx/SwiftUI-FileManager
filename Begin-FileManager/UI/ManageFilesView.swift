//
//  ManageFilesView.swift
//  Begin-FileManager
//
//  Created by Yannis Lang on 29/04/2020.
//  Copyright © 2020 Yannis Lang. All rights reserved.
//

import SwiftUI

struct Human: Codable, Hashable {
    var firstName: String
    var lastName: String
}

struct ManageFilesView: View {
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                      in: .userDomainMask).first!
    let tmpDirURL = FileManager.default.temporaryDirectory
    
    var fileName : URL {
        documentsDirectory.appendingPathComponent("myFile").appendingPathExtension("plist")
    }
    
    
    let dataSet = [
        Human(firstName: "Yannis", lastName: "Lang"),
        Human(firstName: "Toto", lastName: "tata"),
        Human(firstName: "Steve", lastName: "Jobs")
    ]
    
    @State var fileSet = [Human]()
    
    @State private var viewMode = 0
    
    var body: some View {
        
        var selectedData: [Human]
        
        if viewMode == 0 {
            selectedData = dataSet
        }else{
            selectedData = fileSet
        }
        
        return VStack{
            HStack{
                Button(action: {
                    let propertyListEncoder = PropertyListEncoder()
                    let encodedData = try? propertyListEncoder.encode(self.dataSet)

                    try? encodedData?.write(to: self.fileName, options: .noFileProtection)
                }, label: {
                    Text("Save")
                        .padding(.horizontal)
                })
                
                Button(action: {
                    let propertyListDecoder = PropertyListDecoder()
                    if let retrievedNotesData = try? Data(contentsOf: self.fileName),
                        let decodedNotes = try? propertyListDecoder.decode(Array<Human>.self, from: retrievedNotesData) {
                        self.fileSet = decodedNotes
                    }
                }, label: {
                    Text("Load")
                        .padding(.horizontal)
                })
                
                Button(action: {
                    self.fileSet = [Human]()
                    try? FileManager.default.removeItem(at: self.fileName)
                }, label: {
                    Text("Delete")
                        .padding(.horizontal)
                })
            }.padding(.top)
            
            Picker(selection: $viewMode, label: EmptyView()) {
                Text("Properties").tag(0)
                Text("File").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            .padding()
            
            List {
                ForEach(selectedData, id: \.self) { oneHuman in
                    Text("\(oneHuman.firstName) \(oneHuman.lastName)")
                }
            }
        }
    }
}

struct ManageFilesView_Previews: PreviewProvider {
    static var previews: some View {
        ManageFilesView()
    }
}
