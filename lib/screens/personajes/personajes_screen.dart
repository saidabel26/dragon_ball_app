import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dragon_ball_app/app/theme/app_theme.dart';
import 'package:dragon_ball_app/models/personaje.dart';
import 'package:dragon_ball_app/screens/personajes/personaje_detail_screen.dart';

class PersonajesScreen extends StatelessWidget {
  const PersonajesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: AppTheme.background,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'PERSONAJES',
                style: GoogleFonts.rajdhani(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                  color: AppTheme.textPrimary,
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF1A0800), AppTheme.background],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final p = Personaje.personajes[i];
                  return _PersonajeCard(personaje: p, index: i);
                },
                childCount: Personaje.personajes.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonajeCard extends StatefulWidget {
  final Personaje personaje;
  final int index;

  const _PersonajeCard({required this.personaje, required this.index});

  @override
  State<_PersonajeCard> createState() => _PersonajeCardState();
}

class _PersonajeCardState extends State<_PersonajeCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) =>
                PersonajeDetailScreen(personaje: widget.personaje),
            transitionsBuilder: (_, animation, __, child) => FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Hero(
          tag: 'personaje_${widget.personaje.nombre}',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppTheme.surfaceVariant, AppTheme.surface],
              ),
              border: Border.all(
                color: AppTheme.orange.withOpacity(0.25),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.orange.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Character image
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 60,
                    child: Image.asset(
                      widget.personaje.imagen,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Bottom gradient name bar
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0xEE0A0A0F)],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.personaje.nombre.toUpperCase(),
                            style: GoogleFonts.rajdhani(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            widget.personaje.raza,
                            style: GoogleFonts.rajdhani(
                              fontSize: 12,
                              color: AppTheme.orange,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 100 * widget.index),
          duration: 500.ms,
        )
        .slideY(
          begin: 0.3,
          end: 0,
          delay: Duration(milliseconds: 100 * widget.index),
          duration: 500.ms,
          curve: Curves.easeOutCubic,
        );
  }
}
