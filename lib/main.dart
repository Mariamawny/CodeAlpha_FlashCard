// ignore_for_file: unused_field, deprecated_member_use
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modern Flashcard App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Roboto'),
      ),
      home: const FlashcardQuizApp(),
    );
  }
}

class FlashcardQuizApp extends StatefulWidget {
  const FlashcardQuizApp({super.key});

  @override
  State<FlashcardQuizApp> createState() => _FlashcardQuizAppState();
}

class _FlashcardQuizAppState extends State<FlashcardQuizApp>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  bool isFlipped = false;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  final Color primaryColor = const Color(0xFF7B2CBF);
  final Color accentBlue = const Color(0xFF00F0FF);
  final Color accentRed = const Color(0xFFFF3B3B);
  final Color accentGreen = const Color(0xFF00FF88);
  final Color cardBg = const Color(0xFF111111);

  List<Map<String, String>> flashcards = [
    {
      'question': 'What is Flutter?',
      'answer':
          'Flutter is Google\'s open-source UI toolkit for building natively compiled applications for mobile, web, and desktop from a single Dart codebase.',
    },
    {
      'question': 'What language does Flutter use?',
      'answer':
          'Flutter uses Dart — a client-optimized, strongly-typed language developed by Google that compiles to native ARM code or JavaScript.',
    },
    {
      'question':
          'What is the difference between StatelessWidget and StatefulWidget?',
      'answer':
          'StatelessWidget is immutable and never changes after it is built. StatefulWidget can hold mutable state and rebuild when setState() is called.',
    },
    {
      'question': 'What does setState() do?',
      'answer':
          'setState() notifies the Flutter framework that the internal state of a widget has changed, scheduling a rebuild so the UI reflects the new state.',
    },
    {
      'question': 'What is a Widget in Flutter?',
      'answer':
          'Everything in Flutter is a Widget — a lightweight description of part of the UI. Widgets are composed together to build complex interfaces.',
    },
    {
      'question': 'What is the purpose of the BuildContext?',
      'answer':
          'BuildContext is a handle to the location of a widget in the widget tree. It is used to find ancestor widgets, obtain theme data, and navigate.',
    },
    {
      'question': 'What is the difference between hot reload and hot restart?',
      'answer':
          'Hot Reload injects updated code into the running app without losing state. Hot Restart fully restarts the app and resets all state from scratch.',
    },
    {
      'question': 'What is a Future in Dart?',
      'answer':
          'A Future represents a value or error that will be available at some point in the future. It is used for asynchronous operations like network requests.',
    },
    {
      'question': 'What are async and await in Dart?',
      'answer':
          'async marks a function as asynchronous. await pauses execution inside an async function until a Future completes, making async code look synchronous.',
    },
    {
      'question': 'What is a Stream in Dart?',
      'answer':
          'A Stream is a sequence of asynchronous events. Unlike a Future which returns one value, a Stream can emit multiple values over time (e.g., real-time data).',
    },
    {
      'question': 'What is the widget tree?',
      'answer':
          'The widget tree is Flutter\'s hierarchical structure of widgets describing the entire UI. Flutter rebuilds only the parts of the tree that change.',
    },
    {
      'question': 'What is the role of the main() function?',
      'answer':
          'main() is the entry point of every Dart/Flutter app. It calls runApp() which inflates the given widget and attaches it to the screen.',
    },
    {
      'question': 'What is a Key in Flutter?',
      'answer':
          'A Key preserves the state of widgets when they are moved in the widget tree. Common types include ValueKey, ObjectKey, and GlobalKey.',
    },
    {
      'question': 'What is the difference between Row and Column?',
      'answer':
          'Row arranges its children horizontally (along the X-axis), while Column arranges its children vertically (along the Y-axis).',
    },
    {
      'question': 'What is pubspec.yaml?',
      'answer':
          'pubspec.yaml is the configuration file for a Flutter project. It defines the app name, version, dependencies, assets, and fonts used in the project.',
    },
  ];

  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _flipController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _flipController.dispose();
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    if (_flipController.isAnimating) return;
    if (isFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  void _nextCard() {
    if (flashcards.isEmpty) return;
    setState(() {
      currentIndex = (currentIndex + 1) % flashcards.length;
      if (isFlipped) {
        _flipController.reverse();
        isFlipped = false;
      }
    });
  }

  void _prevCard() {
    if (flashcards.isEmpty) return;
    setState(() {
      currentIndex = (currentIndex - 1 + flashcards.length) % flashcards.length;
      if (isFlipped) {
        _flipController.reverse();
        isFlipped = false;
      }
    });
  }

  void _showAddDialog() {
    questionController.clear();
    answerController.clear();
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Dialog(
            backgroundColor: cardBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            elevation: 40,
            shadowColor: primaryColor.withOpacity(0.5),
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add New Flashcard',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: accentBlue,
                          shadows: [
                            Shadow(
                                color: accentBlue.withOpacity(0.2),
                                blurRadius: 10)
                          ])),
                  const SizedBox(height: 24),
                  Text('Question',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: questionController,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.6),
                      hintText: 'Enter the question here...',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.3)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: accentBlue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Answer',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: answerController,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.6),
                      hintText: 'Enter the answer here...',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.3)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: accentBlue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: Colors.white.withOpacity(0.2)),
                          ),
                        ),
                        child: const Text('Cancel',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [primaryColor, accentBlue],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: accentBlue.withOpacity(0.4),
                                blurRadius: 15)
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (questionController.text.isNotEmpty &&
                                answerController.text.isNotEmpty) {
                              setState(() {
                                flashcards.add({
                                  'question': questionController.text,
                                  'answer': answerController.text,
                                });
                                currentIndex = flashcards.length - 1;
                                isFlipped = false;
                                _flipController.reset();
                              });
                              Navigator.of(context).pop();
                            }
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Save Card',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Edit existing card ──
  void _showEditDialog(int index) {
    questionController.text = flashcards[index]['question'] ?? '';
    answerController.text = flashcards[index]['answer'] ?? '';
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Dialog(
            backgroundColor: cardBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            elevation: 40,
            shadowColor: primaryColor.withOpacity(0.5),
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row with edit icon
                  Row(
                    children: [
                      Icon(Icons.edit_rounded, color: accentBlue, size: 22),
                      const SizedBox(width: 10),
                      Text('Edit Flashcard',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: accentBlue,
                              shadows: [
                                Shadow(
                                    color: accentBlue.withOpacity(0.3),
                                    blurRadius: 10)
                              ])),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Question',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: questionController,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.6),
                      hintText: 'Enter the question here...',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.3)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: accentBlue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Answer',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: answerController,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.6),
                      hintText: 'Enter the answer here...',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.3)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: accentBlue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: Colors.white.withOpacity(0.2)),
                          ),
                        ),
                        child: const Text('Cancel',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [primaryColor, accentBlue],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: accentBlue.withOpacity(0.4),
                                blurRadius: 15)
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (questionController.text.isNotEmpty &&
                                answerController.text.isNotEmpty) {
                              setState(() {
                                flashcards[index] = {
                                  'question': questionController.text,
                                  'answer': answerController.text,
                                };
                              });
                              Navigator.of(context).pop();
                            }
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Save Changes',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Delete card with confirmation ──
  void _deleteCard(int index) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Dialog(
            backgroundColor: cardBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: accentRed.withOpacity(0.4)),
            ),
            elevation: 40,
            shadowColor: accentRed.withOpacity(0.5),
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete_forever_rounded,
                      color: accentRed, size: 48),
                  const SizedBox(height: 16),
                  Text('Delete Card?',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: accentRed)),
                  const SizedBox(height: 12),
                  Text(
                    'This flashcard will be permanently deleted.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6), fontSize: 14),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: Colors.white.withOpacity(0.2)),
                          ),
                        ),
                        child: const Text('Cancel',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: accentRed,
                          boxShadow: [
                            BoxShadow(
                                color: accentRed.withOpacity(0.5),
                                blurRadius: 15)
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              flashcards.removeAt(index);
                              if (currentIndex >= flashcards.length &&
                                  currentIndex > 0) {
                                currentIndex = flashcards.length - 1;
                              }
                              isFlipped = false;
                              _flipController.reset();
                            });
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Delete',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton(String text, VoidCallback onTap,
      {bool isPrimary = false}) {
    if (isPrimary) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [primaryColor, accentBlue],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            boxShadow: [
              BoxShadow(color: accentBlue.withOpacity(0.4), blurRadius: 15)
            ],
          ),
          child: Text(text,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 16)),
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 16)),
      ),
    );
  }

  /// Builds one face of the flashcard (front = question, back = answer).
  Widget _buildCardFace({
    required String label,
    required String content,
    required Color borderColor,
    required Color glowColor,
    bool isBack = false,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 600),
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xF9190A0A), Color(0xF90A0F19)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.8),
                blurRadius: 30,
                offset: const Offset(0, 10)),
            BoxShadow(color: glowColor.withOpacity(0.4), blurRadius: 40),
          ],
        ),
        child: Stack(
          children: [
            // Top accent bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(height: 6, color: borderColor),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Text(
                          content,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ), // Padding
          ],
        ), // Stack
      ), // Container
    ); // ClipRRect
  }

  @override
  Widget build(BuildContext context) {
    if (flashcards.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No Flashcards',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 20)),
              const SizedBox(height: 24),
              _buildButton('Add Flashcard', _showAddDialog, isPrimary: true),
            ],
          ),
        ),
      );
    }

    final card = flashcards[currentIndex];
    double sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Positioned.fill(child: _BackgroundEffects()),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // App Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [accentBlue, primaryColor],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds),
                          child: Text(
                            'Flashcard Quiz',
                            style: TextStyle(
                                fontSize: sw < 400 ? 24 : 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),

                      // Card counter
                      Text(
                        '${currentIndex + 1} / ${flashcards.length}',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.5), fontSize: 16),
                      ),

                      GestureDetector(
                        onTap: _showAddDialog,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: accentGreen),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: accentGreen.withOpacity(0.2),
                                  blurRadius: 10),
                            ],
                          ),
                          child: Text(
                            'Add Card',
                            style: TextStyle(
                                color: accentGreen,
                                fontWeight: FontWeight.w600,
                                fontSize: sw < 400 ? 12 : 14),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // ── Flashcard with proper 3-D flip ──
                  GestureDetector(
                    onTap: _toggleFlip,
                    child: AnimatedBuilder(
                      animation: _flipAnimation,
                      builder: (context, child) {
                        final angle = _flipAnimation.value * math.pi;
                        // Show front (question) until we pass the halfway point,
                        // then switch to back (answer) – counter-rotated so it reads
                        // correctly after the card has been rotated past 90°.
                        final showFront = angle <= math.pi / 2;

                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(angle),
                          child: showFront
                              ? _buildCardFace(
                                  label: 'QUESTION',
                                  content: card['question'] ?? '',
                                  borderColor: accentRed,
                                  glowColor: accentRed,
                                )
                              // The card has rotated past 90 ° so its local X-axis
                              // is mirrored. We counter-rotate the CONTENT by π so
                              // the text appears the right way round.
                              : Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..rotateY(math.pi),
                                  child: _buildCardFace(
                                    label: 'ANSWER',
                                    content: card['answer'] ?? '',
                                    borderColor: accentBlue,
                                    glowColor: accentBlue,
                                    isBack: true,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Edit / Delete buttons ──
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Edit button
                      GestureDetector(
                        onTap: () => _showEditDialog(currentIndex),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: accentBlue.withOpacity(0.5)),
                            boxShadow: [
                              BoxShadow(
                                  color: accentBlue.withOpacity(0.15),
                                  blurRadius: 10),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.edit_rounded,
                                  color: accentBlue, size: 16),
                              const SizedBox(width: 8),
                              Text('Edit',
                                  style: TextStyle(
                                      color: accentBlue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Delete button
                      GestureDetector(
                        onTap: () => _deleteCard(currentIndex),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: accentRed.withOpacity(0.5)),
                            boxShadow: [
                              BoxShadow(
                                  color: accentRed.withOpacity(0.15),
                                  blurRadius: 10),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.delete_rounded,
                                  color: accentRed, size: 16),
                              const SizedBox(width: 8),
                              Text('Delete',
                                  style: TextStyle(
                                      color: accentRed,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Bottom Navigation
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildButton('Previous', _prevCard),
                        const SizedBox(width: 12),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _buildButton(
                            isFlipped ? 'Show Question' : 'Show Answer',
                            _toggleFlip,
                            isPrimary: true,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _buildButton('Next', _nextCard),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────── Background ───────────────────────────────

class _BackgroundEffects extends StatefulWidget {
  const _BackgroundEffects();

  @override
  State<_BackgroundEffects> createState() => _BackgroundEffectsState();
}

class _BackgroundEffectsState extends State<_BackgroundEffects>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _pulseController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat(reverse: true);
    _floatController =
        AnimationController(vsync: this, duration: const Duration(seconds: 15))
          ..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Radial glow
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Center(
              child: Transform.scale(
                scale: 1.0 + (_pulseController.value * 0.1),
                child: Opacity(
                  opacity: 0.8 + (_pulseController.value * 0.2),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF7B2CBF).withOpacity(0.15),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.6],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // Floating particles
        AnimatedBuilder(
          animation: _floatController,
          builder: (context, child) {
            final double t = _floatController.value * 2 * math.pi;
            return Stack(
              children: [
                _buildParticle(
                  left: MediaQuery.of(context).size.width * 0.15 +
                      (30 * math.sin(t)),
                  top: MediaQuery.of(context).size.height * 0.2 +
                      (-50 * math.sin(t * 0.5)),
                  size: 50,
                  color: const Color(0xFF00F0FF),
                ),
                _buildParticle(
                  right: MediaQuery.of(context).size.width * 0.2 +
                      (-20 * math.cos(t)),
                  top: MediaQuery.of(context).size.height * 0.15 +
                      (20 * math.cos(t * 0.5)),
                  size: 80,
                  color: const Color(0xFF7B2CBF),
                ),
                _buildParticle(
                  left: MediaQuery.of(context).size.width * 0.25 +
                      (15 * math.cos(t)),
                  bottom: MediaQuery.of(context).size.height * 0.2 +
                      (40 * math.sin(t)),
                  size: 60,
                  color: const Color(0xFF00FF88),
                ),
                _buildParticle(
                  right: MediaQuery.of(context).size.width * 0.15 +
                      (35 * math.sin(t)),
                  bottom: MediaQuery.of(context).size.height * 0.25 +
                      (-30 * math.cos(t)),
                  size: 40,
                  color: const Color(0xFFFF3B3B),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildParticle({
    double? left,
    double? right,
    double? top,
    double? bottom,
    required double size,
    required Color color,
  }) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.5),
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 16,
              spreadRadius: 8,
            )
          ],
        ),
      ),
    );
  }
}
