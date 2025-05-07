//
//  login_page.swift
//  git_profile
//
//  Created by Ibrahim Mohammed on 06/05/2025.
//

import SwiftUI
import SwiftData

struct LoginPage: View {
    @State private var username: String = ""
    @State private var shouldNavigate: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 20) {
                    Image("download")
                        .cornerRadius(60)

                    Text("Login Page")
                        .bold()
                        .font(.title3)
                        .foregroundColor(.white)

                    ZStack(alignment: .leading) {
                        if username.isEmpty {
                            Text("Enter username")
                                .foregroundColor(.white)
                                .padding(.leading, 16)
                        }

                        TextField("", text: $username)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)

                    Button(action: {
                        if !username.isEmpty {
                            shouldNavigate = true
                        }
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                    }
                    .padding(.horizontal)

                    // NavigationLink
                    NavigationLink(destination: ContentView(username: username), isActive: $shouldNavigate) {
                        EmptyView()
                    }
                    .hidden()
                }
                .padding()
            }
        }
    }
}


#Preview {
    LoginPage()
        .modelContainer(for: Item.self, inMemory: true)
}

