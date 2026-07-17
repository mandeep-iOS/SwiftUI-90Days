//
//  ContentView.swift
//  DemoApp_Day2
//
//  Created by Deep Baath on 2026-07-17.
//

import SwiftUI

// MARK: - Root screen with 3 tabs (Form, List, Detail)
struct ContentView: View {
    var body: some View {
        TabView {
            FormDemoView()
                .tabItem { Label("Form", systemImage: "square.and.pencil") }

            ListDemoView()
                .tabItem { Label("List", systemImage: "list.bullet") }

            DetailDemoView()
                .tabItem { Label("Detail", systemImage: "photo") }
        }
    }
}

// MARK: - Screen 1: Form (VStack + modifiers)
struct FormDemoView: View {
    @State private var name: String = ""
    @State private var notifyMe: Bool = true
    @State private var rating: Double = 3

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Enter your name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                Toggle("Notify me", isOn: $notifyMe)
                    .padding(.horizontal)

                VStack(alignment: .leading) {
                    Text("Rating: \(Int(rating))")
                    Slider(value: $rating, in: 1...5, step: 1)
                }
                .padding(.horizontal)

                Text("Hello, \(name.isEmpty ? "stranger" : name)!")
                    .font(.title2)
                    .foregroundStyle(.blue)
                    .padding()
                    .background(.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                Spacer()
            }
            .padding(.top, 30)
            .navigationTitle("Form Demo")
        }
    }
}

// MARK: - Screen 2: List (HStack + modifiers)
struct ListDemoView: View {
    let fruits = [
        ("Apple", "🍎"), ("Banana", "🍌"), ("Mango", "🥭"), ("Grapes", "🍇")
    ]

    var body: some View {
        NavigationStack {
            List(fruits, id: \.0) { fruit in
                HStack {
                    Text(fruit.1)
                        .font(.largeTitle)
                    VStack(alignment: .leading) {
                        Text(fruit.0)
                            .font(.headline)
                        Text("Fresh and healthy")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("List Demo")
        }
    }
}

// MARK: - Screen 3: Detail (ZStack + modifiers)
struct DetailDemoView: View {
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(colors: [.purple, .blue],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    )
                    .frame(height: 220)
                    .padding()

                VStack(alignment: .leading, spacing: 4) {
                    Text("Mountain Trail")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text("A ZStack layers this text over the gradient card")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.85))
                }
                .padding(24)
            }
            .navigationTitle("Detail Demo")
        }
    }
}

#Preview {
    ContentView()
}
