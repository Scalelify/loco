import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var selectedTab = 0
    
    let listings = [
        Listing(id: 1, title: "Packer and Movers", description: "Expert moving services", imageUrl: "https://via.placeholder.com/400x300"),
        Listing(id: 2, title: "Call Center", description: "Customer support services", imageUrl: "https://via.placeholder.com/400x300"),
        Listing(id: 3, title: "Cleaning Services", description: "Professional home cleaning", imageUrl: "https://via.placeholder.com/400x300")
    ]

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search for products, jobs, apartments, services...", text: $searchText)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredList) { listing in
                                NavigationLink(destination: DetailView(listing: listing)) {
                                    HStack(spacing: 12) {
                                        AsyncImage(url: URL(string: listing.imageUrl)) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .overlay(ProgressView())
                                        }
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                        .cornerRadius(12)
                                        .shadow(radius: 2, x: 0, y: 1)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(listing.title)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            
                                            Text(listing.description)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                                .lineLimit(2)
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .cornerRadius(12)
                                    .shadow(radius: 2, x: 0, y: 1)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("Find Jobs, Apartments, & Services")
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(0)
            
            // More tab
            NavigationView {
                Text("More Settings")
                    .navigationTitle("More")
            }
            .tabItem {
                Image(systemName: "line.horizontal.3")
                Text("More")
            }
            .tag(1)
        }
    }
    
    var filteredList: [Listing] {
        if searchText.isEmpty {
            return listings
        }
        return listings.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
}

struct Listing: Identifiable {
    let id: Int
    let title: String
    let description: String
    let imageUrl: String
}

struct DetailView: View {
    let listing: Listing
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: listing.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(ProgressView())
                }
                .frame(height: 250)
                .clipped()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(listing.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(listing.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Button(action: contact) {
                        Text("Contact")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func contact() {
        // Contact action
    }
}
