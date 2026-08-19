class Caminhada {
  String partida;
  String chegada;
  double distanciaEmKm;
  double pesoAtualKg;

  Caminhada({
    required this.partida,
    required this.chegada,
    required this.distanciaEmKm,
    required this.pesoAtualKg,
  });

  double get calorias {
    return 0.7 * pesoAtualKg * distanciaEmKm;
  }

  Map<String, dynamic> toMap() {
    return {
      'partida': partida,
      'chegada': chegada,
      'distancia_em_km': distanciaEmKm,
      'peso_atual_kg': pesoAtualKg,
    };
  }

  factory Caminhada.fromMap(Map<String, dynamic> map) {
    return Caminhada(
      partida: map['partida'],
      chegada: map['chegada'],
      distanciaEmKm: (map['distancia_em_km'] as num).toDouble(),
      pesoAtualKg: (map['peso_atual_kg'] as num).toDouble(),
    );
  }
}