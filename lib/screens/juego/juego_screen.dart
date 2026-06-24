import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dragon_ball_app/app/theme/app_theme.dart';

// ── Quiz data ─────────────────────────────────────────────────────────────────

class _Pregunta {
  final String pregunta;
  final List<String> opciones;
  final int correcta;

  const _Pregunta({
    required this.pregunta,
    required this.opciones,
    required this.correcta,
  });
}

const List<_Pregunta> _preguntas = [
  _Pregunta(
    pregunta: '¿En qué torneo despierta Goku el Ultra Instinto por primera vez?',
    opciones: [
      'Torneo de los Dioses',
      'Torneo del Universo 6',
      'Torneo del Poder',
      'Torneo de las Artes Marciales',
    ],
    correcta: 2,
  ),
  _Pregunta(
    pregunta: '¿Quién es el Dios de la Destrucción del Universo 7?',
    opciones: ['Champa', 'Sidra', 'Beerus', 'Belmod'],
    correcta: 2,
  ),
  _Pregunta(
    pregunta: '¿De qué planeta proviene originalmente Broly?',
    opciones: ['Vegeta', 'Vampa', 'Namek', 'Kakarot'],
    correcta: 1,
  ),
  _Pregunta(
    pregunta: '¿Cuántos episodios tiene Dragon Ball Super?',
    opciones: ['100', '120', '131', '150'],
    correcta: 2,
  ),
  _Pregunta(
    pregunta: '¿Quién crea la Fusión Potara entre Caulifla y Kale?',
    opciones: ['Champa', 'Vados', 'El Dios Rey', 'Ellas mismas'],
    correcta: 3,
  ),
  _Pregunta(
    pregunta: '¿Cómo se llama el ángel asistente de Beerus?',
    opciones: ['Cus', 'Vados', 'Whis', 'Marcarita'],
    correcta: 2,
  ),
  _Pregunta(
    pregunta: '¿Qué técnica usa Vegeta para alcanzar el Ultra Ego?',
    opciones: [
      'Meditación divina',
      'Entrenamiento con Whis',
      'Entrenamiento con Beerus',
      'Ritual Super Saiyan',
    ],
    correcta: 2,
  ),
  _Pregunta(
    pregunta: '¿Cuál es el nombre del villano que usa el cuerpo de Goku en el futuro?',
    opciones: ['Black Vegeta', 'Goku Black', 'Zamasu Goku', 'Dark Kakarot'],
    correcta: 1,
  ),
  _Pregunta(
    pregunta: '¿Qué le pasa al universo que pierde el Torneo del Poder?',
    opciones: [
      'Pierde sus Esferas del Dragón',
      'Es exiliado',
      'Es destruido por el Rey Todo',
      'Sus guerreros mueren',
    ],
    correcta: 2,
  ),
  _Pregunta(
    pregunta: '¿Quién es el creador de la serie Dragon Ball Super?',
    opciones: [
      'Eiichiro Oda',
      'Masashi Kishimoto',
      'Akira Toriyama',
      'Toyotarou',
    ],
    correcta: 2,
  ),
];

// ── Rank logic ────────────────────────────────────────────────────────────────

String _getRango(int score) {
  if (score == 10) return '¡ULTRA INSTINTO DOMINADO!';
  if (score >= 8) return '¡SUPER SAIYAN GOD!';
  if (score >= 6) return '¡SUPER SAIYAN BLUE!';
  if (score >= 4) return '¡SUPER SAIYAN!';
  if (score >= 2) return 'Guerrero Z';
  return 'Seguidor de Freezer…';
}

Color _getRangoColor(int score) {
  if (score == 10) return Colors.white;
  if (score >= 8) return AppTheme.gold;
  if (score >= 6) return AppTheme.blue;
  if (score >= 4) return AppTheme.orange;
  if (score >= 2) return Colors.green;
  return Colors.purpleAccent;
}

// ── Screen ────────────────────────────────────────────────────────────────────

class JuegoScreen extends StatefulWidget {
  const JuegoScreen({super.key});

  @override
  State<JuegoScreen> createState() => _JuegoScreenState();
}

class _JuegoScreenState extends State<JuegoScreen>
    with SingleTickerProviderStateMixin {
  // Game state
  bool _started = false;
  bool _finished = false;
  int _questionIndex = 0;
  int _score = 0;
  int _selectedOption = -1;
  bool _answered = false;
  late List<_Pregunta> _shuffled;

  // Timer
  int _timeLeft = 20;
  Timer? _timer;
  late AnimationController _timerController;

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _shuffled = List.from(_preguntas)..shuffle(Random());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timerController.dispose();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      _started = true;
      _finished = false;
      _questionIndex = 0;
      _score = 0;
      _selectedOption = -1;
      _answered = false;
      _shuffled = List.from(_preguntas)..shuffle(Random());
    });
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timeLeft = 20;
    _timerController.reset();
    _timerController.forward();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() => _timeLeft--);
      if (_timeLeft <= 0) {
        t.cancel();
        if (!_answered) _selectAnswer(-1);
      }
    });
  }

  void _selectAnswer(int index) {
    if (_answered) return;
    _timer?.cancel();
    _timerController.stop();
    final isCorrect = index == _shuffled[_questionIndex].correcta;
    setState(() {
      _answered = true;
      _selectedOption = index;
      if (isCorrect) _score++;
    });
    Future.delayed(const Duration(milliseconds: 1200), _nextQuestion);
  }

  void _nextQuestion() {
    if (!mounted) return;
    if (_questionIndex >= _shuffled.length - 1) {
      setState(() => _finished = true);
      return;
    }
    setState(() {
      _questionIndex++;
      _answered = false;
      _selectedOption = -1;
    });
    _startTimer();
  }

  Color _optionColor(int i) {
    if (!_answered) return AppTheme.surfaceVariant;
    if (i == _shuffled[_questionIndex].correcta) {
      return Colors.green.shade800;
    }
    if (i == _selectedOption) return Colors.red.shade800;
    return AppTheme.surfaceVariant;
  }

  Color _optionBorderColor(int i) {
    if (!_answered) return AppTheme.divider;
    if (i == _shuffled[_questionIndex].correcta) return Colors.green;
    if (i == _selectedOption) return Colors.red;
    return AppTheme.divider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: !_started
            ? _buildIntro()
            : _finished
                ? _buildResults()
                : _buildQuestion(),
      ),
    );
  }

  // ── Intro ────────────────────────────────────────────────────────────────

  Widget _buildIntro() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.quiz_rounded,
              size: 80,
              color: AppTheme.orange,
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.1, 1.1),
                  duration: 1200.ms,
                )
                .then()
                .scale(
                  begin: const Offset(1.1, 1.1),
                  end: const Offset(1, 1),
                  duration: 1200.ms,
                ),
            const SizedBox(height: 28),
            Text(
              'JUEGA CONMIGO',
              style: GoogleFonts.rajdhani(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [AppTheme.orange, AppTheme.gold],
                  ).createShader(const Rect.fromLTWH(0, 0, 280, 40)),
                letterSpacing: 3,
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 8),
            Text(
              'Quiz Dragon Ball Super',
              style: GoogleFonts.rajdhani(
                fontSize: 18,
                color: AppTheme.textSecondary,
                letterSpacing: 1,
              ),
            ).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.orange.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  _RuleRow(icon: Icons.help_outline, text: '10 preguntas sobre la serie'),
                  const SizedBox(height: 10),
                  _RuleRow(
                    icon: Icons.timer_outlined,
                    text: '20 segundos por pregunta',
                  ),
                  const SizedBox(height: 10),
                  _RuleRow(
                    icon: Icons.emoji_events_outlined,
                    text: 'Descubre tu rango de guerrero',
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _startGame,
                child: const Text('¡COMENZAR!'),
              ),
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
          ],
        ),
      ),
    );
  }

  // ── Question ─────────────────────────────────────────────────────────────

  Widget _buildQuestion() {
    final q = _shuffled[_questionIndex];
    final progress = (_questionIndex + 1) / _shuffled.length;
    final timeColor = _timeLeft > 10
        ? AppTheme.orange
        : _timeLeft > 5
            ? Colors.orange
            : Colors.red;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pregunta ${_questionIndex + 1}/10',
                style: GoogleFonts.rajdhani(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.timer, color: timeColor, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '$_timeLeft s',
                    style: GoogleFonts.rajdhani(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: timeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppTheme.surface,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppTheme.orange),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),

          // Timer bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: AnimatedBuilder(
              animation: _timerController,
              builder: (_, __) => LinearProgressIndicator(
                value: 1.0 - _timerController.value,
                backgroundColor: AppTheme.surface,
                valueColor: AlwaysStoppedAnimation<Color>(timeColor),
                minHeight: 4,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Question
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Score chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.orange.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.orange.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: AppTheme.gold,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$_score correctas',
                          style: GoogleFonts.rajdhani(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Question text
                  Text(
                    q.pregunta,
                    style: GoogleFonts.rajdhani(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                      height: 1.4,
                    ),
                  ).animate(key: ValueKey(_questionIndex)).fadeIn(
                        duration: 400.ms,
                      ),
                  const SizedBox(height: 28),

                  // Options
                  ...q.opciones.asMap().entries.map((e) {
                    final i = e.key;
                    final opt = e.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => _selectAnswer(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: _optionColor(i),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _optionBorderColor(i),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color:
                                      AppTheme.orange.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    ['A', 'B', 'C', 'D'][i],
                                    style: GoogleFonts.rajdhani(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: AppTheme.orange,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  opt,
                                  style: GoogleFonts.rajdhani(
                                    fontSize: 16,
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (_answered)
                                Icon(
                                  i == q.correcta
                                      ? Icons.check_circle_rounded
                                      : (i == _selectedOption
                                          ? Icons.cancel_rounded
                                          : null),
                                  color: i == q.correcta
                                      ? Colors.green
                                      : Colors.red,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      ).animate(key: ValueKey('$_questionIndex-$i')).fadeIn(
                            delay: Duration(milliseconds: 80 * i),
                            duration: 350.ms,
                          ).slideX(
                            begin: 0.15,
                            end: 0,
                            delay: Duration(milliseconds: 80 * i),
                          ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Results ───────────────────────────────────────────────────────────────

  Widget _buildResults() {
    final rango = _getRango(_score);
    final rangoColor = _getRangoColor(_score);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Trophy
            Icon(
              _score >= 8
                  ? Icons.emoji_events_rounded
                  : _score >= 5
                      ? Icons.military_tech_rounded
                      : Icons.sentiment_neutral_rounded,
              size: 80,
              color: rangoColor,
            )
                .animate()
                .scale(
                  begin: const Offset(0, 0),
                  end: const Offset(1, 1),
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                ),
            const SizedBox(height: 20),

            // Score
            Text(
              '$_score/10',
              style: GoogleFonts.rajdhani(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [rangoColor, AppTheme.gold],
                  ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
              ),
            ).animate().fadeIn(delay: 300.ms),

            // Rank
            Text(
              rango,
              textAlign: TextAlign.center,
              style: GoogleFonts.rajdhani(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: rangoColor,
                letterSpacing: 1,
              ),
            ).animate().fadeIn(delay: 500.ms),
            const SizedBox(height: 12),

            Text(
              _score == 10
                  ? '¡Perfecto! Eres un verdadero maestro de Dragon Ball Super.'
                  : _score >= 7
                      ? '¡Excelente conocimiento de la serie!'
                      : _score >= 5
                          ? 'Bien, pero aún puedes mejorar. ¡Sigue entrenando!'
                          : 'Necesitas ver Dragon Ball Super de nuevo. 😅',
              textAlign: TextAlign.center,
              style: GoogleFonts.rajdhani(
                fontSize: 15,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
            ).animate().fadeIn(delay: 600.ms),
            const SizedBox(height: 36),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _startGame,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('INTENTAR DE NUEVO'),
              ),
            ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0),
          ],
        ),
      ),
    );
  }
}

// ── Helper widget ─────────────────────────────────────────────────────────────

class _RuleRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _RuleRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.orange, size: 20),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.rajdhani(
            fontSize: 15,
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
