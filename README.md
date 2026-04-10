# 📚 Modern Flashcard Quiz App

A beautiful, modern Flutter flashcard application with smooth 3D flip animation and dark theme.

## ✨ Features

- **3D Flip Animation**: Smooth card flip animation with proper perspective
- **Add/Edit/Delete Cards**: Manage your flashcard collection easily
- **Dark Theme**: Modern dark UI with gradient accents
- **Responsive Design**: Works perfectly on all screen sizes and emulators
- **Smooth Navigation**: Previous/Next card controls
- **Beautiful UI**: 
  - Gradient accents (Purple, Cyan, Green, Red)
  - Floating particle effects in background
  - Glass morphism dialogs
  - Smooth animations and transitions

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (version 3.0.0 or higher)
- Dart SDK
- Android Studio or VS Code
- Emulator or Physical Device

### Installation

1. **Clone or extract the project**
   ```bash
   cd flashcard_app
   ```

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📱 How to Use

1. **Start Learning**: The app comes with 15 Flutter-related flashcards
2. **Flip Cards**: Tap on the card to flip between question and answer
3. **Navigate**: Use Previous/Next buttons to browse cards
4. **Add New Card**: Click "Add Card" button to create new flashcards
5. **Edit Cards**: Click "Edit" to modify existing cards
6. **Delete Cards**: Click "Delete" to remove cards

## 🎨 Color Scheme

- **Primary Color**: #7B2CBF (Purple)
- **Accent Blue**: #00F0FF (Cyan)
- **Accent Red**: #FF3B3B (Red)
- **Accent Green**: #00FF88 (Green)
- **Background**: #000000 (Black)

## 📁 Project Structure

```
flashcard_app/
├── lib/
│   └── main.dart          # Main application file
├── assets/                # Assets folder (for future use)
├── pubspec.yaml          # Project configuration
├── .gitignore            # Git ignore rules
└── README.md             # This file
```

## 🎯 Key Features Explained

### Optimized Buttons
The bottom navigation buttons are fully responsive:
- **Expanded widgets** ensure proper sizing on all screens
- **Flexible layout** adapts to screen size
- Minimum spacing prevents overlap

### 3D Card Flip
- Uses `Transform` with `Matrix4` for 3D perspective
- Smooth animation with `AnimationController`
- Proper text rotation counter-flip

### Dialog Management
- Glass morphism effect with `BackdropFilter`
- Elegant animations
- Form validation before save

## 🛠️ Customization

### Change Flashcards
Edit the `flashcards` list in `_FlashcardQuizAppState`:
```dart
List<Map<String, String>> flashcards = [
  {
    'question': 'Your question here',
    'answer': 'Your answer here',
  },
  // Add more cards...
];
```

### Modify Colors
Update the color constants:
```dart
final Color primaryColor = const Color(0xFF7B2CBF);
final Color accentBlue = const Color(0xFF00F0FF);
```

### Adjust Animation Speed
Change duration in `initState`:
```dart
_flipController = AnimationController(
    vsync: this, 
    duration: const Duration(milliseconds: 600) // Change this
);
```

## 📊 Default Flashcards

The app comes with 15 Flutter Q&A cards covering:
- What is Flutter?
- Flutter language (Dart)
- StatelessWidget vs StatefulWidget
- setState() method
- Widget architecture
- BuildContext
- Hot reload vs Hot restart
- Futures in Dart
- Async/Await
- Streams
- Widget tree
- main() function
- Keys in Flutter
- Row vs Column
- pubspec.yaml

## 🐛 Troubleshooting

### App won't run
```bash
flutter clean
flutter pub get
flutter run
```

### Buttons not displaying properly
- Check device orientation
- Ensure screen size is sufficient
- Verify all dependencies are installed

### Animation issues
- Update Flutter SDK
- Clear build cache: `flutter clean`

## 📄 License

This project is open source and available for personal and commercial use.

## 🤝 Contributing

Feel free to fork, modify, and improve this project!

## 💡 Tips

- The app saves flashcards in memory only (restart loses data)
- To persist data, consider adding local storage (Hive, SharedPreferences)
- Can be extended with categories, progress tracking, and spaced repetition

---

**Made with ❤️ using Flutter**
