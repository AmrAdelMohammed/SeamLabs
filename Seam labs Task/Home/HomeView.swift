//
//  ContentView.swift
//  Seam labs Task
//
//  Created by Amr Adel on 04/09/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeVM
    
    init(viewModel: HomeVM = HomeVM()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("")
    }
  
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
