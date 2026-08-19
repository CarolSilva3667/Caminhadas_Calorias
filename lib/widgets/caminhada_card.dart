import 'package:flutter/material.dart';
import '../models/caminhada.dart';

class CaminhadaCard extends StatelessWidget {
  final Caminhada caminhada;
  final VoidCallback excluir;
  final VoidCallback editar;

  const CaminhadaCard({
    super.key,
    required this.caminhada,
    required this.excluir,
    required this.editar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: editar,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.directions_walk,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${caminhada.partida} → ${caminhada.chegada}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      '${caminhada.distanciaEmKm.toStringAsFixed(1)} km • '
                      '${caminhada.pesoAtualKg.toStringAsFixed(1)} kg',
                    ),

                    const SizedBox(height: 5),

                    Text(
                      '${caminhada.calorias.toStringAsFixed(1)} kcal',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: excluir,
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Excluir',
              ),
            ],
          ),
        ),
      ),
    );
  }
}