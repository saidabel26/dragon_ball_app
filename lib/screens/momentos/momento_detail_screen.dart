import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dragon_ball_app/app/theme/app_theme.dart';
import 'package:dragon_ball_app/models/momento.dart';

class MomentoDetailScreen extends StatefulWidget {
  final Momento momento;

  const MomentoDetailScreen({super.key, required this.momento});

  @override
  State<MomentoDetailScreen> createState() => _MomentoDetailScreenState();
}

class _MomentoDetailScreenState extends State<MomentoDetailScreen> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.momento.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () => setState(() => _isFullScreen = true),
      onExitFullScreen: () => setState(() => _isFullScreen = false),
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppTheme.orange,
        progressColors: const ProgressBarColors(
          playedColor: AppTheme.orange,
          handleColor: AppTheme.gold,
        ),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: AppTheme.background,
          body: Column(
            children: [
              // Player (no AppBar when building this)
              if (!_isFullScreen)
                SafeArea(
                  bottom: false,
                  child: Stack(
                    children: [
                      player,
                      Positioned(
                        top: 8,
                        left: 8,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                player,

              // Content below video
              if (!_isFullScreen)
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Orange accent line
                        Container(
                          width: 40,
                          height: 3,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppTheme.orange, AppTheme.gold],
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Title
                        Text(
                          widget.momento.titulo,
                          style: GoogleFonts.rajdhani(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textPrimary,
                            letterSpacing: 0.5,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Divider
                        Container(
                          height: 1,
                          color: AppTheme.divider,
                        ),
                        const SizedBox(height: 20),

                        // Description label
                        Text(
                          'DESCRIPCIÓN',
                          style: GoogleFonts.rajdhani(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.orange,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Description text
                        Text(
                          widget.momento.descripcion,
                          style: GoogleFonts.rajdhani(
                            fontSize: 16,
                            color: AppTheme.textSecondary,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
