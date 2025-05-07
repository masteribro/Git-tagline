//
//  ContentView.swift
//  git_profile
//
//  Created by Ibrahim Mohammed on 26/04/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let username: String
    @State private var user:GitHubUser?
    

    var body: some View {
        ZStack{
            Color.black
            .ignoresSafeArea()
            VStack(spacing:20){
                
                AsyncImage(url: URL(string: user?.avatarUrl ?? "")){image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                    
                }placeholder: {
                    Circle().foregroundColor(.secondary)
                        
                }.frame(width: 120, height: 120)
                
                
                Text(user?.name ?? "User Name")
                    .bold()
                    .font(.title3)
                    .foregroundColor(.white)
                HStack{
                    Text("@\(user?.login ?? "User Name")")
                        .foregroundColor(.white)
                        .bold()
                 
                }
                
                Text(user?.bio ?? "No Bio" )
                    .padding()
                    .foregroundColor(.white)
                
                 
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Location:")
                                .foregroundColor(.white)
                                .bold()
                            Text(user?.location ?? "N/A")
                                .foregroundColor(.white)
                        }

                        HStack {
                            Text("Public Repos:")
                                .foregroundColor(.white)
                                .bold()
                            Text("\(user?.publicRepos ?? 0)")
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                
                
            }
            .task {
                do{
                    user = try await getUser()
                }catch GHError.invalidResponse{
                    print("invalid url")
                }catch{
                    print("Error")
                }
            }
        }
   
    }
        

    func getUser()async throws->GitHubUser{
      let endpoint = "https://api.github.com/users/\(username)"
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidResponse
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as?   HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw GHError.invalidResponse
            
        }
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        }catch{
            throw GHError.decodingFailed
        }
       
    }
}

#Preview {
    ContentView(username: "masteribro") 
        .modelContainer(for: Item.self, inMemory: true)
}
struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String?
    let name: String?
    let location: String?
    let publicRepos: Int?
}

enum GHError: Error {
    case invalidResponse
    case decodingFailed
}

