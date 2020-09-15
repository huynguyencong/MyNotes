//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Nguyen Cong Huy on 9/16/20.
//  Copyright © 2020 Nguyen Cong Huy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    enum PresentationType: String {
        case push = "Push"
        case present = "Present"
    }
    
    @State private var presentationType: PresentationType = .push
    let pickerSelections: [PresentationType] = [.push, .present]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select presentation type", selection: $presentationType) {
                    ForEach(pickerSelections, id: \.self) { value in
                        Text(value.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                  
                if presentationType == .present {
                    ListViewPresentCoordinator()
                }
                else {
                    ListViewPushCoordinator()
                }
            }
        }
        .onAppear {
            self.presentationType = self.pickerSelections[0]
        }
    }
}

// MARK: - Views

struct ListView: View {
    let onItemSelected: (Int) -> Void
    
    var body: some View {
        List {
            ForEach(1..<100) { value in
                Button("\(value)") {
                    self.onItemSelected(value)
                }
            }
        }
        .navigationBarTitle("List view")
    }
}

struct DetailView: View {
    let value: Int
    
    var body: some View {
        Text("Value \(value)")
            .navigationBarTitle("Detail view")
    }
}

// MARK: - Coordinators

struct ListViewPushCoordinator: View {
    @State private var isActive = false
    @State private var selectedItem: Int?
    
    var body: some View {
        VStack {
            ListView(onItemSelected: onItemSelected(item:))
            
            if selectedItem != nil {
                NavigationLink(destination: DetailView(value: selectedItem!), isActive: $isActive, label: { EmptyView() })
            }
        }
    }
    
    private func onItemSelected(item: Int) {
        self.selectedItem = item
        self.isActive = true
    }
}

struct ListViewPresentCoordinator: View {
    @State private var isActive = false
    @State private var selectedItem: Int?
    
    var body: some View {
        ListView(onItemSelected: onItemSelected(item:))
            .sheet(isPresented: $isActive) {
                DetailView(value: self.selectedItem!)
        }
    }
    
    private func onItemSelected(item: Int) {
        self.selectedItem = item
        self.isActive = true
    }
}
