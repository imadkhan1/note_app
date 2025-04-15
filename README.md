# 📝 Note App

A simple Flutter application for managing notes. This app allows users to create, read, update, and delete notes using a local SQLite database.

## 🚀 Features

- Add new notes with a title and description.
- View a list of all saved notes.
- Edit existing notes.
- Delete notes.
- Persistent storage using SQLite.

## 📸 Screenshots

| Home Screen | Add Note | Edit Note |
| ----------- | -------- | --------- |
|             |          |           |

## 💠 Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/your-username/note_app.git
   cd note_app
   ```

2. **Install dependencies**:

   ```bash
   flutter pub get
   ```

3. **Run the app**:

   ```bash
   flutter run
   ```

## 📁 Project Structure

- `lib/db/db_helper.dart` – Handles all database operations.
- `lib/models/note.dart` – Note model.
- `lib/screens/home_screen.dart` – Main screen UI.
- `lib/widgets/note_form.dart` – Bottom sheet for adding/editing notes.

## 📦 Dependencies

The app uses the following Flutter packages:

- [`sqflite`](https://pub.dev/packages/sqflite): For SQLite database operations.
- [`path_provider`](https://pub.dev/packages/path_provider): For accessing device file paths.
- [`path`](https://pub.dev/packages/path): For file path operations.

These are already listed in `pubspec.yaml`.

## ⚙️ How It Works

### Database Initialization

The `DbHelper` class initializes the SQLite database and creates a table for storing notes.

### CRUD Operations

- **Add a note**: `addNote()` method in `DbHelper`.
- **Retrieve all notes**: `getAllNotes()` method in `DbHelper`.
- **Update a note**: `updateNote()` method in `DbHelper`.
- **Delete a note**: `deleteNote()` method in `DbHelper`.

### UI

- `HomeScreen` displays the list of notes.
- A bottom sheet is used to add or edit notes.
- Floating action button (FAB) to create a new note.

## ▶️ Usage

1. Launch the app.
2. Tap the ➕ button to add a new note.
3. Tap ✏️ to edit a note.
4. Tap 🗑️ to delete a note.

## 🤝 Contributing

Contributions are welcome! Follow these steps:

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make your changes and commit:
   ```bash
   git commit -m "Add your message"
   ```
4. Push to your branch:
   ```bash
   git push origin feature/your-feature-name
   ```
5. Open a pull request.

## 📄 License

This project is licensed under the [MIT License](LICENSE).

## 📬 Contact

For questions or feedback:

- **Email**: [Mikykhan702@gmail.com](mailto\:Mikykhan702@gmail.com)
- **GitHub**: github.com/imadkhan1

