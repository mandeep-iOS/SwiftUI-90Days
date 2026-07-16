//
//  ContentView.swift
//  DemoApp_Day1
//
//  Created by Deep Baath on 2026-07-16.
//

import SwiftUI

// MARK: - Model
struct User: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let role: String
}

// MARK: - Actor: thread-safe shared counter
actor ViewCounter {
    private var count = 0
    func increment() -> Int {
        count += 1
        return count
    }
}

let sharedCounter = ViewCounter()

// MARK: - @Observable ViewModel
@Observable
class UserListViewModel {
    var users: [User] = []
    var isLoading = false

    func fetchUsers() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 1_000_000_000) // simulate network delay
        users = [
            User(name: "Aisha Khan", role: "iOS Developer"),
            User(name: "Marco Rossi", role: "Backend Engineer"),
            User(name: "Priya Sharma", role: "Designer")
        ]
        isLoading = false
    }
}

// MARK: - Main screen: NavigationStack
struct ContentView: View {
    @State private var viewModel = UserListViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading users...")
                } else {
                    List(viewModel.users) { user in
                        NavigationLink(value: user) {
                            VStack(alignment: .leading) {
                                Text(user.name).font(.headline)
                                Text(user.role).font(.subheadline).foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Team Directory")
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

// MARK: - Detail screen: async/await + actor
struct UserDetailView: View {
    let user: User
    @State private var viewCount: Int = 0

    var body: some View {
        VStack(spacing: 16) {
            Text(user.name).font(.largeTitle)
            Text(user.role).font(.title3).foregroundStyle(.secondary)
            Text("This screen has been viewed \(viewCount) times")
                .font(.footnote)
                .padding(.top, 20)
        }
        .padding()
        .navigationTitle("Profile")
        .task {
            viewCount = await sharedCounter.increment()
        }
    }
}

#Preview {
    ContentView()
}
//Just updated
