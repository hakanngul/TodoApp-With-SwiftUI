//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by Hakan Gül on 11.03.2023.
//

import SwiftUI

/*
MVVM Architectıre
Model - data point
View  - UI
ViewModel - Manages model for View
    
 */

@main
struct TodoListAppApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
