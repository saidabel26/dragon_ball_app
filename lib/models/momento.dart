class Momento {
  final String titulo;
  final String videoId;
  final String descripcion;

  const Momento({
    required this.titulo,
    required this.videoId,
    required this.descripcion,
  });

  String get thumbnailUrl =>
      'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';

  static const List<Momento> momentos = [
    Momento(
      titulo: '¡Goku Despierta El Ultra Instinto Por Primera Vez!',
      videoId: 'ORsOrU8klFE',
      descripcion:
          'En el Torneo del Poder, acorralado y al borde de la derrota, Goku desata una energía nunca antes vista. Su cuerpo comienza a moverse solo, sin pensar, sin dudar — el Ultra Instinto toca la puerta por primera vez y sacude hasta a los propios Dioses.',
    ),
    Momento(
      titulo: '¡Deja De Destruir Cosas!',
      videoId: 'icJCt_qLq9I',
      descripcion:
          'Chi-Chi, la valiente esposa de Goku, enfrenta sin miedo ni titubeo a Beerus, el Dios de la Destrucción. Un momento que mezcla humor y tensión al máximo, recordándonos que el coraje no siempre viene del poder.',
    ),
    Momento(
      titulo: 'Goku vs Kefla - Final Kamehameha',
      videoId: 'xekjE_wtOwk',
      descripcion:
          'Con el Ultra Instinto destellando en sus ojos, Goku se enfrenta a Kefla, la poderosa Potara Fusión de Caulifla y Kale. Un Kamehameha definitivo que rompe los límites del universo y deja sin palabras a todos en el estadio de los Dioses.',
    ),
  ];
}
