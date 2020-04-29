//
//  ShowPathView.swift
//  Begin-FileManager
//
//  Created by Yannis Lang on 29/04/2020.
//  Copyright © 2020 Yannis Lang. All rights reserved.
//

import SwiftUI

struct ShowPathView: View {
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                      in: .userDomainMask).first!
    
    let tmpDirURL = FileManager.default.temporaryDirectory
    
    var body: some View {
        VStack(spacing : 20){
            Text("Document: \(documentsDirectory)")
            Text("Tmp: \(tmpDirURL)")
        }
        .onAppear{
            print(self.documentsDirectory)
            print(self.tmpDirURL)
        }
    }
}

struct ShowPathView_Previews: PreviewProvider {
    static var previews: some View {
        ShowPathView()
    }
}
