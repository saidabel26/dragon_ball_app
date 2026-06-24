import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dragon_ball_app/app/theme/app_theme.dart';

class ContactoScreen extends StatelessWidget {
  const ContactoScreen({super.key});

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
                'CONTÁCTAME',
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
                    colors: [Color(0xFF000A1A), AppTheme.background],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
              child: Column(
                children: [
                  // Profile card
                  _ProfileCard(),
                  const SizedBox(height: 24),

                  // Skills section
                  _SkillsSection(),
                  const SizedBox(height: 24),

                  // Social links
                  _SocialSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Profile card ──────────────────────────────────────────────────────────────

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
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
            color: AppTheme.orange.withOpacity(0.1),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar
          Stack(
            alignment: Alignment.center,
            children: [
              // Glow ring
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const SweepGradient(
                    colors: [AppTheme.orange, AppTheme.gold, AppTheme.orange],
                  ),
                ),
              ),
              // Photo
              Container(
                width: 104,
                height: 104,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.background,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/mi_foto.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ).animate().scale(
                begin: const Offset(0.7, 0.7),
                end: const Offset(1, 1),
                duration: 600.ms,
                curve: Curves.elasticOut,
              ),
          const SizedBox(height: 16),

          // Name
          Text(
            'Said Abel De Oleo Reyes',
            textAlign: TextAlign.center,
            style: GoogleFonts.rajdhani(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
              letterSpacing: 0.5,
            ),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 4),

          // Bio
          Text(
            'Software Developer',
            style: GoogleFonts.rajdhani(
              fontSize: 16,
              color: AppTheme.orange,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ).animate().fadeIn(delay: 300.ms),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }
}

// ── Skills section ────────────────────────────────────────────────────────────

class _SkillsSection extends StatelessWidget {
  static const _skills = [
    'SOLID Principles',
    'Clean Code',
    'OOP',
    'Design Patterns',
    'Software Architecture',
    'Git',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel('Principal Skills'),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _skills.asMap().entries.map((e) {
            return _SkillChip(label: e.value, index: e.key);
          }).toList(),
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final int index;

  const _SkillChip({required this.label, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppTheme.orange.withOpacity(0.35),
          width: 1.5,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.rajdhani(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppTheme.textPrimary,
          letterSpacing: 0.3,
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 80 * index),
          duration: 400.ms,
        )
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          delay: Duration(milliseconds: 80 * index),
          duration: 400.ms,
          curve: Curves.easeOutBack,
        );
  }
}

// ── Social section ────────────────────────────────────────────────────────────

class _SocialSection extends StatelessWidget {
  static final _links = [
    _SocialLink(
      icon: Icons.work_outline_rounded,
      label: 'LinkedIn',
      handle: 'saiddeoleo',
      url: 'https://www.linkedin.com/in/saiddeoleo',
      color: const Color(0xFF0A66C2),
    ),
    _SocialLink(
      icon: Icons.code_rounded,
      label: 'GitHub',
      handle: 'saidabel26',
      url: 'https://github.com/saidabel26',
      color: const Color(0xFFEEEEEE),
    ),
    _SocialLink(
      icon: Icons.code_rounded,
      label: 'GitLab',
      handle: 'saidabel26',
      url: 'https://gitlab.com/saidabel26',
      color: const Color(0xFFFCA121),
    ),
    _SocialLink(
      icon: Icons.email_rounded,
      label: 'Email',
      handle: 'saiddeoleo26@gmail.com',
      url: 'mailto:saiddeoleo26@gmail.com',
      color: const Color(0xFFEA4335),
    ),
    _SocialLink(
      icon: Icons.chat_bubble_outline_rounded,
      label: 'WhatsApp',
      handle: '+1 (809) 869-9144',
      url: 'https://wa.me/18098699144',
      color: const Color(0xFF25D366),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel('Redes'),
        const SizedBox(height: 14),
        ..._links.asMap().entries.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _SocialCard(link: e.value, index: e.key),
          ),
        ),
      ],
    );
  }
}

class _SocialCard extends StatefulWidget {
  final _SocialLink link;
  final int index;

  const _SocialCard({required this.link, required this.index});

  @override
  State<_SocialCard> createState() => _SocialCardState();
}

class _SocialCardState extends State<_SocialCard> {
  bool _pressed = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.link.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        _launch();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: AppTheme.surfaceVariant,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.link.color.withOpacity(0.25),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: widget.link.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.link.icon,
                  color: widget.link.color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.link.label,
                      style: GoogleFonts.rajdhani(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textSecondary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      widget.link.handle,
                      style: GoogleFonts.rajdhani(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.open_in_new_rounded,
                color: widget.link.color.withOpacity(0.6),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 80 * widget.index),
          duration: 400.ms,
        )
        .slideX(
          begin: 0.1,
          end: 0,
          delay: Duration(milliseconds: 80 * widget.index),
        );
  }
}

// ── Helper classes & widgets ──────────────────────────────────────────────────

class _SocialLink {
  final IconData icon;
  final String label;
  final String handle;
  final String url;
  final Color color;

  const _SocialLink({
    required this.icon,
    required this.label,
    required this.handle,
    required this.url,
    required this.color,
  });
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
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
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: AppTheme.textPrimary,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
