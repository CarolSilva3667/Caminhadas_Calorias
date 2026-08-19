import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/caminhada.dart';

class StorageService {
  static const String chave = 'caminhadas';

  static Future<void> salvarCaminhadas(List<Caminhada> caminhadas) async {
    final prefs = await SharedPreferences.getInstance();

    final lista = caminhadas.map((caminhada) => caminhada.toMap()).toList();

    await prefs.setString(chave, jsonEncode(lista));
  }

  static Future<List<Caminhada>> carregarCaminhadas() async {
    final prefs = await SharedPreferences.getInstance();

    final dados = prefs.getString(chave);

    if (dados == null) {
      return [];
    }

    final List lista = jsonDecode(dados);

    return lista
        .map((item) => Caminhada.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }
}