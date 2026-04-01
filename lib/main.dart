import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const DokuApp());
}

class DokuApp extends StatelessWidget {
  const DokuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B82F6)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const String _docImageUrl =
      'http://localhost:3845/assets/d83ad303b2eab771cac229c5ef969e546dffdc70.png';

  static const double _designWidth = 393.796;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final scale = constraints.maxWidth / _designWidth;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF8FAFC),
                  Color(0xFFFFFFFF),
                  Color(0xFFEFF6FF),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 21.8 * scale,
                  top: -128 * scale,
                  child: _softCircle(
                    size: 500 * scale,
                    color: const Color(0xFF3B82F6).withOpacity(0.06),
                  ),
                ),
                Positioned(
                  left: -160 * scale,
                  top: 412.18 * scale,
                  child: _softCircle(
                    size: 600 * scale,
                    color: const Color(0xFF1E3A8A).withOpacity(0.04),
                  ),
                ),
                Positioned(
                  left: 106.9 * scale,
                  top: 293.6 * scale,
                  child: SizedBox(
                    width: 180 * scale,
                    height: 180 * scale,
                    child: Stack(
                      children: [
                        Positioned(
                          left: -50 * scale,
                          top: -50 * scale,
                          child: Container(
                            width: 280 * scale,
                            height: 280 * scale,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0x143B82F6),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x143B82F6),
                                  blurRadius: 64 * scale,
                                  spreadRadius: 8 * scale,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Image.network(
                            _docImageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Color(0xFFE2E8F0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.insert_drive_file_rounded,
                                    size: 56,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 489.58 * scale,
                  left: 0,
                  right: 0,
                  child: Text(
                    'Smart Document Management',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF64748B),
                      fontSize: 14 * scale.clamp(0.9, 1.15),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.35,
                      height: 1.5,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                Positioned(
                  top: 550.57 * scale,
                  left: 0,
                  right: 0,
                  child: const _LoadingDots(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _softCircle({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _LoadingDots extends StatelessWidget {
  const _LoadingDots();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _Dot(size: 11.146, opacity: 0.87),
        SizedBox(width: 4),
        _Dot(size: 9.779, opacity: 0.56),
        SizedBox(width: 4),
        _Dot(size: 8.16, opacity: 0.41),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Color(0xFF3B82F6),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
