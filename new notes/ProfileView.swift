//
//  ProfileView.swift
//  new notes
//
//  Created by Monika Suresh Ilamkar on 14/11/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext

    // Fetch or create a single Profile record
    @Query private var profiles: [Profile]
    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        let profile = ensureProfile()

        Form {
            Section("Profile") {
                HStack(spacing: 16) {
                    ZStack {
                        if let data = profile.imageData, let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.appPink, lineWidth: 2))
                        } else {
                            Circle()
                                .fill(Color.appPink.opacity(0.2))
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 32, weight: .semibold))
                                        .foregroundStyle(.appPink)
                                )
                        }
                    }
                    .overlay(alignment: .bottomTrailing) {
                        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                            Image(systemName: "camera.fill")
                                .font(.system(size: 14, weight: .bold))
                                .padding(6)
                                .background(Circle().fill(Color.white))
                                .overlay(Circle().stroke(Color.appPink, lineWidth: 1))
                                .foregroundStyle(.appPink)
                        }
                        .buttonStyle(.plain)
                        .padding(2)
                    }

                    VStack(alignment: .leading) {
                        TextField("Your name", text: binding(for: \.name, on: profile))
                        TextField("Short bio", text: binding(for: \.bio, on: profile), axis: .vertical)
                            .lineLimit(1...3)
                    }
                }
            }
            .listRowBackground(Color.appPink.opacity(0.08))

            Section {
                Text("Hello Good Noon!")
                    .foregroundStyle(.secondary)
            }
            .listRowBackground(Color.appPink.opacity(0.08))
        }
        .scrollContentBackground(.hidden)
        .background(Color.appPink.opacity(0.05))
        .tint(.appPink)
        .navigationTitle("Profile")
        .task(id: selectedItem) {
            await loadSelectedPhoto(into: profile)
        }
    }

    // Ensure a single Profile exists
    private func ensureProfile() -> Profile {
        if let existing = profiles.first {
            return existing
        } else {
            let new = Profile()
            modelContext.insert(new)
            return new
        }
    }

    // Create a @Binding to a property on the Profile instance
    private func binding<Value>(for keyPath: ReferenceWritableKeyPath<Profile, Value>, on profile: Profile) -> Binding<Value> {
        Binding(
            get: { profile[keyPath: keyPath] },
            set: { newValue in
                profile[keyPath: keyPath] = newValue
                try? modelContext.save()
            }
        )
    }

    // Load picked photo and save to SwiftData
    private func loadSelectedPhoto(into profile: Profile) async {
        guard let item = selectedItem else { return }
        do {
            if let data = try await item.loadTransferable(type: Data.self) {
                await MainActor.run {
                    profile.imageData = data
                    try? modelContext.save()
                }
            }
        } catch {
            // Handle errors as needed (e.g., show alert)
            print("Failed to load photo: \(error)")
        }
    }
}

#Preview {
    NavigationStack { ProfileView() }
        .modelContainer(for: [Note.self, Profile.self], inMemory: true)
}

