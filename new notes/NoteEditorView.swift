//
//  NoteEditorView.swift
//  new notes
//
//  Created by Monika Suresh Ilamkar on 14/11/25.
//

import SwiftUI
import SwiftData

struct NoteEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var note: Note

    private let fontOptions: [String] = [
        "System",
        "Georgia",
        "Times New Roman",
        "Helvetica Neue",
        "Courier New",
        "Avenir Next",
        "Menlo"
    ]

    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section {
                    TextField("Title", text: $note.title)
                        .font(.headline)
                }
                .listRowBackground(Color.appPink.opacity(0.08))

                Section("Formatting") {
                    Picker("Font", selection: $note.fontName) {
                        ForEach(fontOptions, id: \.self) { name in
                            Text(name).tag(name)
                        }
                    }
                    HStack {
                        Text("Size")
                        Slider(value: $note.fontSize, in: 12...34, step: 1) {
                            Text("Font Size")
                        }
                        Text("\(Int(note.fontSize)) pt")
                            .monospacedDigit()
                            .foregroundStyle(.secondary)
                    }
                }
                .listRowBackground(Color.appPink.opacity(0.08))
            }
            .scrollContentBackground(.hidden)
            .background(Color.appPink.opacity(0.05))

            Divider()

            // Editor
            TextEditor(text: $note.content)
                .font(resolvedFont())
                .padding()
                .background(Color.white)
                .scrollContentBackground(.hidden)
        }
        .navigationTitle(note.title.isEmpty ? "New Note" : "Edit Note")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") { dismiss() }
                    .tint(.appPink)
            }
        }
        .background(Color.appPink.opacity(0.05))
    }

    private func resolvedFont() -> Font {
        if note.fontName == "System" {
            return .system(size: note.fontSize)
        } else {
            return .custom(note.fontName, size: note.fontSize)
        }
    }
}

#Preview {
    let note = Note(title: "Sample", content: "Write your note here...", fontName: "System", fontSize: 18)
    return NavigationStack {
        NoteEditorView(note: note)
    }
    .modelContainer(for: Note.self, inMemory: true)
}
