class Personaje {
  final String nombre;
  final String imagen;
  final String raza;
  final String nivelPoder;
  final String descripcion;
  final List<String> tecnicas;
  final String transformacion;

  const Personaje({
    required this.nombre,
    required this.imagen,
    required this.raza,
    required this.nivelPoder,
    required this.descripcion,
    required this.tecnicas,
    required this.transformacion,
  });

  static const List<Personaje> personajes = [
    Personaje(
      nombre: 'Goku',
      imagen: 'assets/Goku.png',
      raza: 'Saiyan',
      nivelPoder: 'Nivel de Dios',
      transformacion: 'Ultra Instinto Dominado',
      descripcion:
          'El guerrero más poderoso del Universo 7. Nacido como Kakarot, Goku ha superado constantemente sus límites, alcanzando el Ultra Instinto, una técnica que ni los propios Dioses logran dominar fácilmente.',
      tecnicas: [
        'Kamehameha',
        'Genkidama',
        'Kaio-Ken',
        'Ultra Instinto',
        'Super Saiyan Blue',
      ],
    ),
    Personaje(
      nombre: 'Vegeta',
      imagen: 'assets/Vegeta.png',
      raza: 'Saiyan',
      nivelPoder: 'Nivel de Dios',
      transformacion: 'Ultra Ego',
      descripcion:
          'El Príncipe de los Saiyans, orgulloso y determinado. Vegeta ha forjado su propio camino hacia el poder, alcanzando el Ultra Ego a través de un entrenamiento con el Dios de la Destrucción Beerus.',
      tecnicas: [
        'Galick Gun',
        'Final Flash',
        'Big Bang Attack',
        'Super Saiyan Blue Evolucionado',
        'Ultra Ego',
      ],
    ),
    Personaje(
      nombre: 'Maestro Roshi',
      imagen: 'assets/Roshi.png',
      raza: 'Humano',
      nivelPoder: 'Maestro Legendario',
      transformacion: 'Modo Máximo',
      descripcion:
          'El Maestro Kame, fundador del Kame Style. Aunque aparenta ser un viejo excéntrico, Roshi es un guerrero de élite que sorprendió a todos en el Torneo del Poder con su dominio del Ki y su sabiduría infinita.',
      tecnicas: [
        'Kamehameha (original)',
        'MAX Power Kamehameha',
        'Modo Máximo',
        'Mafuba (Sello del Diablo)',
        'Jackie Chun Style',
      ],
    ),
    Personaje(
      nombre: 'Broly',
      imagen: 'assets/Broly.png',
      raza: 'Saiyan Legendario',
      nivelPoder: 'Incalculable',
      transformacion: 'Super Saiyan Legendario',
      descripcion:
          'El Saiyan Legendario con un potencial de batalla que crece sin límite durante el combate. Broly fue exiliado por el Rey Vegeta al nacer por miedo a su poder inmenso, criándose en el planeta Vampa junto a su padre Paragus.',
      tecnicas: [
        'Eraser Cannon',
        'Gigantic Meteor',
        'Super Saiyan Legendario',
        'Wrathful Form',
        'Gigantic Roar',
      ],
    ),
  ];
}
