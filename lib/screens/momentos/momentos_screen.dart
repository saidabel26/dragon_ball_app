import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dragon_ball_app/app/theme/app_theme.dart';
import 'package:dragon_ball_app/models/momento.dart';
import 'package:dragon_ball_app/screens/momentos/momento_detail_screen.dart';

class MomentosScreen extends StatelessWidget {
  const MomentosScreen({super.key});

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
                'MOMENTOS',
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
                    colors: [Color(0xFF001020), AppTheme.background],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final m = Momento.momentos[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _MomentoCard(momento: m, index: i),
                  );
                },
                childCount: Momento.momentos.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MomentoCard extends StatefulWidget {
  final Momento momento;
  final int index;

  const _MomentoCard({required this.momento, required this.index});

  @override
  State<_MomentoCard> createState() => _MomentoCardState();
}

class _MomentoCardState extends State<_MomentoCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MomentoDetailScreen(momento: widget.momento),
          ),
        );
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.surfaceVariant,
            border: Border.all(
              color: AppTheme.blue.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.blue.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.momento.thumbnailUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: AppTheme.surface,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.orange,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: AppTheme.surface,
                          child: const Icon(
                            Icons.play_circle_outline,
                            color: AppTheme.orange,
                            size: 48,
                          ),
                        ),
                      ),
                      // Play overlay
                      Center(
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.65),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 34,
                          ),
                        ),
                      ),
                      // Number badge
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppTheme.orange, AppTheme.gold],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '#${widget.index + 1}',
                            style: GoogleFonts.rajdhani(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Title
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.momento.titulo,
                          style: GoogleFonts.rajdhani(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                            letterSpacing: 0.3,
                            height: 1.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppTheme.orange,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 150 * widget.index),
          duration: 500.ms,
        )
        .slideX(
          begin: 0.2,
          end: 0,
          delay: Duration(milliseconds: 150 * widget.index),
          duration: 500.ms,
          curve: Curves.easeOutCubic,
        );
  }
}
