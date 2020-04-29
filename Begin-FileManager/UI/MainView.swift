//
//  MainView.swift
//  Begin-FileManager
//
//  Created by Yannis Lang on 29/04/2020.
//  Copyright © 2020 Yannis Lang. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            ShowPathView()
                .tabItem{
                    Image(systemName: "doc.on.doc.fill")
            }
            ManageFilesView()
                .tabItem{
                    Image(systemName: "arrow.down.doc.fill")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
