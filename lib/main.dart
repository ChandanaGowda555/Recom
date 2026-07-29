import 'package:flutter/material.dart';
import 'dart:async';
import 'page_landing.dart';

void main() {
  runApp(const RecomApp());
}

class RecomApp extends StatefulWidget {
  const RecomApp({super.key});

  @override
  State<RecomApp> createState() => _RecomAppState();
}

class _RecomAppState extends State<RecomApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RECOM.',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
        cardColor: Colors.white,
        hintColor: const Color(0xFF64748B),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF3B82F6),
          secondary: Color(0xFF06B6D4),
          surface: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF060913),
        cardColor: const Color(0xFF0F1626).withAlpha(180),
        hintColor: const Color(0xFF64748B),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF3B82F6),
          secondary: Color(0xFF06B6D4),
          surface: Color(0xFF0F1626),
        ),
      ),
      home: SplashScreenController(onThemeToggle: toggleTheme),
    );
  }
}

// 🎬 BRAND ANIMATED SPLASH SCREEN
class SplashScreenController extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const SplashScreenController({super.key, required this.onThemeToggle});

  @override
  State<SplashScreenController> createState() => _SplashScreenControllerState();
}

class _SplashScreenControllerState extends State<SplashScreenController> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  int _iconIndex = 0;
  late Timer _iconTimer;

  final List<IconData> _animatedIcons = [
    Icons.phone_iphone_rounded,
    Icons.laptop_mac_rounded,
    Icons.tv_rounded,
    Icons.air_rounded,
    Icons.watch_rounded,
    Icons.camera_alt_rounded,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _fadeAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    // Cycle through device icons
    _iconTimer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (mounted) {
        setState(() {
          _iconIndex = (_iconIndex + 1) % _animatedIcons.length;
        });
      }
    });

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ActionLandingPage(onThemeToggle: widget.onThemeToggle)),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _iconTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060913),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [const Color(0xFF06B6D4).withAlpha(40), Colors.transparent],
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Icon(
                    _animatedIcons[_iconIndex],
                    key: ValueKey<int>(_iconIndex),
                    size: 60,
                    color: const Color(0xFF06B6D4),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'RECOM.',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.5,
                  foreground: Paint()..shader = const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)]
                  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'CIRCULAR ECONOMY ENGINE',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}