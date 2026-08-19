import 'package:flutter/material.dart';

import '../models/caminhada.dart';
import '../services/storage_service.dart';
import '../widgets/caminhada_card.dart';
import '../widgets/caminhada_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Caminhada> caminhadas = [];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    final dados = await StorageService.carregarCaminhadas();

    setState(() {
      caminhadas = dados;
    });
  }

  Future<void> salvarDados() async {
    await StorageService.salvarCaminhadas(caminhadas);
  }

  Future<void> adicionarCaminhada() async {
    final resultado = await showModalBottomSheet<Caminhada>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return const CaminhadaForm();
      },
    );

    if (resultado != null) {
      setState(() {
        caminhadas.add(resultado);
      });

      await salvarDados();
    }
  }

  Future<void> editarCaminhada(int index) async {
    final resultado = await showModalBottomSheet<Caminhada>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return CaminhadaForm(caminhada: caminhadas[index]);
      },
    );

    if (resultado != null) {
      setState(() {
        caminhadas[index] = resultado;
      });

      await salvarDados();
    }
  }

  Future<void> excluirCaminhada(int index) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir caminhada?'),
          content: const Text('Essa caminhada será removida permanentemente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      setState(() {
        caminhadas.removeAt(index);
      });

      await salvarDados();
    }
  }

  double get totalCalorias {
    return caminhadas.fold(0, (total, caminhada) => total + caminhada.calorias);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas caminhadas')),

      body: caminhadas.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_walk_outlined, size: 80),
                  SizedBox(height: 20),
                  Text(
                    'Nenhuma caminhada registrada',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Toque no + para adicionar uma caminhada.'),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Total de calorias',
                          style: TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          '${totalCalorias.toStringAsFixed(1)} kcal',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text('${caminhadas.length} caminhada(s)'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                ...List.generate(caminhadas.length, (index) {
                  return CaminhadaCard(
                    caminhada: caminhadas[index],
                    editar: () => editarCaminhada(index),
                    excluir: () => excluirCaminhada(index),
                  );
                }),
              ],
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: adicionarCaminhada,
        child: const Icon(Icons.add),
      ),
    );
  }
}