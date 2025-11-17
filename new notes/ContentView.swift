//
//  ContentView.swift
//  new notes
//
//  Created by Monika Suresh Ilamkar on 14/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    // Sort newest first
    @Query(sort: \Note.timestamp, order: .reverse)
    private var notes: [Note]

    var body: some View {
        TabView {
            NavigationStack {
                List {
                    ForEach(notes) { note in
                        NavigationLink(value: note) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(note.title.isEmpty ? "Untitled" : note.title)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                Text(note.content)
                                    .lineLimit(2)
                                    .foregroundStyle(.secondary)
                                    .font(.subheadline)
                            }
                        }
                        .listRowBackground(Color.appPink.opacity(0.08))
                    }
                    .onDelete(perform: deleteNotes)
                }
                .navigationTitle("Notes")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addNote()
                        } label: {
                            Label("Add Note", systemImage: "plus")
                        }
                        .tint(.appPink)
                    }
                }
                .navigationDestination(for: Note.self) { note in
                    NoteEditorView(note: note)
                }
                .background(Color.appPink.opacity(0.05))
            }
            .tabItem {
                Label("Notes", systemImage: "note.text")
            }

            NavigationStack {
                ProfileView()
                    .navigationTitle("Profile")
                    .background(Color.appPink.opacity(0.05))
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
        }
        .tint(.appPink)
    }

    private func addNote() {
        withAnimation {
            let note = Note(title: "", content: "", fontName: "System", fontSize: 18, timestamp: Date())
            modelContext.insert(note)
        }
    }

    private func deleteNotes(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Note.self, inMemory: true)
}
