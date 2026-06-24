import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dragon_ball_app/app/theme/app_theme.dart';

class AcercaDeScreen extends StatelessWidget {
  const AcercaDeScreen({super.key});

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
                'ACERCA DE',
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
                    colors: [Color(0xFF100A00), AppTheme.background],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero banner
                  _HeroBanner(),
                  const SizedBox(height: 28),

                  // Info cards grid
                  _SectionTitle('La Serie'),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.4,
                    children: const [
                      _InfoCard(
                        icon: Icons.calendar_today_rounded,
                        label: 'Estreno',
                        value: '5 jul. 2015',
                        color: AppTheme.blue,
                      ),
                      _InfoCard(
                        icon: Icons.tv_rounded,
                        label: 'Episodios',
                        value: '131',
                        color: AppTheme.orange,
                      ),
                      _InfoCard(
                        icon: Icons.layers_rounded,
                        label: 'Arcos',
                        value: '5 arcos',
                        color: AppTheme.gold,
                      ),
                      _InfoCard(
                        icon: Icons.flag_rounded,
                        label: 'Final',
                        value: '25 mar. 2018',
                        color: AppTheme.blueLight,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  _SectionTitle('Creador'),
                  const SizedBox(height: 12),
                  _CreatorCard(),
                  const SizedBox(height: 28),

                  _SectionTitle('Arcos Argumentales'),
                  const SizedBox(height: 12),
                  ..._arcos.asMap().entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _ArcoCard(
                        index: e.key + 1,
                        titulo: e.value['titulo']!,
                        episodios: e.value['episodios']!,
                        descripcion: e.value['descripcion']!,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _SectionTitle('Sinopsis'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.divider),
                    ),
                    child: Text(
                      'Dragon Ball Super es la secuela directa de Dragon Ball Z, ambientada después de la derrota de Majin Buu. La serie narra las nuevas aventuras de Goku y sus amigos, quienes deben hacer frente a amenazas que van más allá de los límites del universo conocido.\n\nDurante la serie, los guerreros del Universo 7 se enfrentan a Dioses de la Destrucción, descubren otros universos paralelos y participan en el Torneo del Poder, una batalla multiversal donde el universo perdedor es borrado de la existencia.',
                      style: GoogleFonts.rajdhani(
                        fontSize: 15,
                        color: AppTheme.textSecondary,
                        height: 1.7,
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data ──────────────────────────────────────────────────────────────────────

const _arcos = [
  {
    'titulo': 'La Batalla de los Dioses',
    'episodios': 'Ep. 1 – 14',
    'descripcion':
        'Beerus, el Dios de la Destrucción, busca al Super Saiyan God. Goku debe alcanzar este poder divino para enfrentarlo.',
  },
  {
    'titulo': 'La Resurrección de F',
    'episodios': 'Ep. 15 – 27',
    'descripcion':
        'Los seguidores de Freezer logran revivirlo. Decidido a vengarse de Goku, Freezer regresa transformado en "Freezer Dorado".',
  },
  {
    'titulo': 'Universo 6 vs Universo 7',
    'episodios': 'Ep. 28 – 46',
    'descripcion':
        'El Dios de la Destrucción Champa desafía a Beerus en un torneo entre universos para decidir quién se queda con las Esferas del Dragón.',
  },
  {
    'titulo': 'Trunks del Futuro / Zamasu',
    'episodios': 'Ep. 47 – 76',
    'descripcion':
        'Trunks llega del futuro perseguido por Goku Black, un enemigo que usa el cuerpo de Goku con una Ki oscura y misteriosa.',
  },
  {
    'titulo': 'Torneo del Poder',
    'episodios': 'Ep. 77 – 131',
    'descripcion':
        '12 universos compiten en una batalla multiversal. El universo perdedor será borrado por el Rey Todo. El Universo 7 debe luchar por su supervivencia.',
  },
];

// ── Widgets ───────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.orange, AppTheme.gold],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text.toUpperCase(),
          style: GoogleFonts.rajdhani(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppTheme.textPrimary,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A0800), Color(0xFF0A0A1A)],
        ),
        border: Border.all(
          color: AppTheme.orange.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Text(
            'DRAGON BALL',
            style: GoogleFonts.rajdhani(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSecondary,
              letterSpacing: 5,
            ),
          ),
          Text(
            'SUPER',
            style: GoogleFonts.rajdhani(
              fontSize: 52,
              fontWeight: FontWeight.w900,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [AppTheme.orange, AppTheme.gold],
                ).createShader(const Rect.fromLTWH(0, 0, 300, 60)),
              letterSpacing: 8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'ドラゴンボール超',
            style: GoogleFonts.rajdhani(
              fontSize: 14,
              color: AppTheme.textSecondary,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
        );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.rajdhani(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.rajdhani(
              fontSize: 12,
              color: AppTheme.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms, delay: 200.ms)
        .slideY(begin: 0.2, end: 0);
  }
}

class _CreatorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.gold.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppTheme.orange, AppTheme.gold],
              ),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Akira Toriyama',
                style: GoogleFonts.rajdhani(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                'Mangaka / Creador de Dragon Ball',
                style: GoogleFonts.rajdhani(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '5 abr. 1955 — 1 mar. 2024',
                style: GoogleFonts.rajdhani(
                  fontSize: 12,
                  color: AppTheme.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 300.ms);
  }
}

class _ArcoCard extends StatelessWidget {
  final int index;
  final String titulo;
  final String episodios;
  final String descripcion;

  const _ArcoCard({
    required this.index,
    required this.titulo,
    required this.episodios,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.orange, AppTheme.gold],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '$index',
                style: GoogleFonts.rajdhani(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        titulo,
                        style: GoogleFonts.rajdhani(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      episodios,
                      style: GoogleFonts.rajdhani(
                        fontSize: 11,
                        color: AppTheme.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  descripcion,
                  style: GoogleFonts.rajdhani(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 100 * index),
          duration: 500.ms,
        )
        .slideX(begin: -0.1, end: 0);
  }
}
