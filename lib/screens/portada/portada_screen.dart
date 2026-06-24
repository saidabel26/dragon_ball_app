import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dragon_ball_app/screens/home/home_screen.dart';
import 'package:dragon_ball_app/app/theme/app_theme.dart';

class PortadaScreen extends StatefulWidget {
  const PortadaScreen({super.key});

  @override
  State<PortadaScreen> createState() => _PortadaScreenState();
}

class _PortadaScreenState extends State<PortadaScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  bool _videoReady = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _controller = VideoPlayerController.asset('assets/portada.mp4')
      ..initialize().then((_) {
        setState(() => _videoReady = true);
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _entrarApp() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (_, animation, __) => const HomeScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Video background ─────────────────────────────────────────────
          if (_videoReady)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            )
          else
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0xFF1A0A00), AppTheme.background],
                  radius: 1.2,
                ),
              ),
            ),

          // ── Dark gradient overlay ─────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x55000000),
                  Color(0x22000000),
                  Color(0xBB000000),
                  Color(0xFF000000),
                ],
                stops: [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),

          // ── Ki aura effect ────────────────────────────────────────────────
          AnimatedBuilder(
            animation: _pulseController,
            builder: (_, __) {
              return Center(
                child: Container(
                  width: 300 + (_pulseController.value * 40),
                  height: 300 + (_pulseController.value * 40),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppTheme.orange.withOpacity(
                          0.08 + _pulseController.value * 0.06,
                        ),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // ── Content ───────────────────────────────────────────────────────
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Title section
                Column(
                  children: [
                    Text(
                      'DRAGON BALL',
                      style: GoogleFonts.rajdhani(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 6,
                        shadows: [
                          Shadow(
                            color: AppTheme.orange.withOpacity(0.8),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 300.ms, duration: 800.ms)
                        .slideY(begin: -0.3, end: 0),
                    Text(
                      'SUPER',
                      style: GoogleFonts.rajdhani(
                        fontSize: 72,
                        fontWeight: FontWeight.w900,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [AppTheme.orange, AppTheme.gold],
                          ).createShader(
                            const Rect.fromLTWH(0, 0, 250, 80),
                          ),
                        letterSpacing: 10,
                        shadows: [
                          Shadow(
                            color: AppTheme.orange.withOpacity(0.9),
                            blurRadius: 30,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 800.ms)
                        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
                    const SizedBox(height: 8),
                    Container(
                      width: 160,
                      height: 2,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppTheme.orange,
                            AppTheme.gold,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 700.ms, duration: 600.ms),
                  ],
                ),
                const SizedBox(height: 60),

                // Enter button
                GestureDetector(
                  onTap: _entrarApp,
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (_, child) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.orange.withOpacity(
                                0.4 + _pulseController.value * 0.3,
                              ),
                              blurRadius: 20 + _pulseController.value * 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: child,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 56,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.orange, Color(0xFFFF8C00)],
                        ),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: AppTheme.gold.withOpacity(0.5),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        'COMENZAR',
                        style: GoogleFonts.rajdhani(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 900.ms, duration: 600.ms)
                    .slideY(begin: 0.5, end: 0),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
