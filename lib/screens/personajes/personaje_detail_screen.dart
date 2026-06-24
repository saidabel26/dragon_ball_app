import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dragon_ball_app/app/theme/app_theme.dart';
import 'package:dragon_ball_app/models/personaje.dart';

class PersonajeDetailScreen extends StatelessWidget {
  final Personaje personaje;

  const PersonajeDetailScreen({super.key, required this.personaje});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          // ── Hero image app bar ──────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 420,
            pinned: true,
            backgroundColor: AppTheme.background,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'personaje_${personaje.nombre}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(personaje.imagen, fit: BoxFit.cover),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Color(0xBB000000),
                            AppTheme.background,
                          ],
                          stops: [0.0, 0.5, 0.8, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Details ─────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    personaje.nombre.toUpperCase(),
                    style: GoogleFonts.rajdhani(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [AppTheme.orange, AppTheme.gold],
                        ).createShader(const Rect.fromLTWH(0, 0, 300, 50)),
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Race + transformation
                  Row(
                    children: [
                      _Tag(label: personaje.raza, color: AppTheme.blue),
                      const SizedBox(width: 8),
                      Flexible(
                        child: _Tag(
                          label: personaje.transformacion,
                          color: AppTheme.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Power level
                  _InfoRow(
                    icon: Icons.bolt_rounded,
                    label: 'Nivel de Poder',
                    value: personaje.nivelPoder,
                  ),
                  const SizedBox(height: 20),

                  // Divider
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppTheme.divider,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description
                  Text(
                    'Historia',
                    style: GoogleFonts.rajdhani(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.orange,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    personaje.descripcion,
                    style: GoogleFonts.rajdhani(
                      fontSize: 16,
                      color: AppTheme.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Techniques
                  Text(
                    'Técnicas',
                    style: GoogleFonts.rajdhani(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.orange,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...personaje.tecnicas.map(
                    (t) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppTheme.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            t,
                            style: GoogleFonts.rajdhani(
                              fontSize: 16,
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w500,
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
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;

  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: GoogleFonts.rajdhani(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.orange.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.orange, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.rajdhani(
                fontSize: 12,
                color: AppTheme.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.rajdhani(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
