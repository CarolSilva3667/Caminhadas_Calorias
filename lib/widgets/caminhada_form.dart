import 'package:flutter/material.dart';
import '../models/caminhada.dart';

class CaminhadaForm extends StatefulWidget {
  final Caminhada? caminhada;

  const CaminhadaForm({super.key, this.caminhada});

  @override
  State<CaminhadaForm> createState() => _CaminhadaFormState();
}

class _CaminhadaFormState extends State<CaminhadaForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController partidaController;
  late TextEditingController chegadaController;
  late TextEditingController distanciaController;
  late TextEditingController pesoController;

  @override
  void initState() {
    super.initState();

    partidaController = TextEditingController(
      text: widget.caminhada?.partida ?? '',
    );

    chegadaController = TextEditingController(
      text: widget.caminhada?.chegada ?? '',
    );

    distanciaController = TextEditingController(
      text: widget.caminhada?.distanciaEmKm.toString() ?? '',
    );

    pesoController = TextEditingController(
      text: widget.caminhada?.pesoAtualKg.toString() ?? '',
    );
  }

  @override
  void dispose() {
    partidaController.dispose();
    chegadaController.dispose();
    distanciaController.dispose();
    pesoController.dispose();

    super.dispose();
  }

  void salvar() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final caminhada = Caminhada(
      partida: partidaController.text.trim(),
      chegada: chegadaController.text.trim(),
      distanciaEmKm: double.parse(
        distanciaController.text.replaceAll(',', '.'),
      ),
      pesoAtualKg: double.parse(pesoController.text.replaceAll(',', '.')),
    );

    Navigator.pop(context, caminhada);
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.caminhada != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                editando ? 'Editar caminhada' : 'Nova caminhada',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: partidaController,
                decoration: const InputDecoration(
                  labelText: 'Partida',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe a partida';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: chegadaController,
                decoration: const InputDecoration(
                  labelText: 'Chegada',
                  prefixIcon: Icon(Icons.flag_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe a chegada';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: distanciaController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Distância (km)',
                  prefixIcon: Icon(Icons.straighten),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe a distância';
                  }

                  final numero = double.tryParse(value.replaceAll(',', '.'));

                  if (numero == null || numero <= 0) {
                    return 'Informe uma distância válida';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: pesoController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Peso atual (kg)',
                  prefixIcon: Icon(Icons.monitor_weight_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o peso';
                  }

                  final numero = double.tryParse(value.replaceAll(',', '.'));

                  if (numero == null || numero <= 0) {
                    return 'Informe um peso válido';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: salvar,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(editando ? 'SALVAR ALTERAÇÕES' : 'SALVAR'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}