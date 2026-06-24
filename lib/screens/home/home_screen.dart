import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dragon_ball_app/app/theme/app_theme.dart';
import 'package:dragon_ball_app/screens/personajes/personajes_screen.dart';
import 'package:dragon_ball_app/screens/momentos/momentos_screen.dart';
import 'package:dragon_ball_app/screens/acerca_de/acerca_de_screen.dart';
import 'package:dragon_ball_app/screens/juego/juego_screen.dart';
import 'package:dragon_ball_app/screens/contacto/contacto_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    PersonajesScreen(),
    MomentosScreen(),
    AcercaDeScreen(),
    JuegoScreen(),
    ContactoScreen(),
  ];

  final List<_NavItem> _navItems = const [
    _NavItem(icon: Icons.people_alt_rounded, label: 'Personajes'),
    _NavItem(icon: Icons.play_circle_filled_rounded, label: 'Momentos'),
    _NavItem(icon: Icons.info_rounded, label: 'Acerca de'),
    _NavItem(icon: Icons.games_rounded, label: 'Juega'),
    _NavItem(icon: Icons.person_rounded, label: 'Contáctame'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          boxShadow: [
            BoxShadow(
              color: AppTheme.orange.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
          border: const Border(
            top: BorderSide(color: AppTheme.divider, width: 1),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (i) {
                final item = _navItems[i];
                final isSelected = i == _currentIndex;
                return GestureDetector(
                  onTap: () => setState(() => _currentIndex = i),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: isSelected
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppTheme.orange.withOpacity(0.12),
                          )
                        : null,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          child: Icon(
                            item.icon,
                            color:
                                isSelected ? AppTheme.orange : AppTheme.textSecondary,
                            size: isSelected ? 26 : 22,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.label,
                          style: GoogleFonts.rajdhani(
                            fontSize: 10,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: isSelected
                                ? AppTheme.orange
                                : AppTheme.textSecondary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}
