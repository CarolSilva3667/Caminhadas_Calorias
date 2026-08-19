# Caminhadas x Calorias

Aplicativo mobile desenvolvido em **Flutter** para registrar caminhadas e calcular o gasto calórico estimado.

## Sobre o projeto

O aplicativo permite cadastrar caminhadas informando:

* Partida
* Chegada
* Distância em km
* Peso atual em kg

O cálculo das calorias é feito pela fórmula:

```text
Calorias = 0,7 × peso × distância
```

### Exemplo

```text
0,7 × 60 × 5 = 210 kcal
```

## Funcionalidades

* Tela Splash
* Tema claro e escuro
* Cadastro de caminhadas
* Lista de caminhadas
* Cálculo automático de calorias
* Edição de caminhadas
* Exclusão de caminhadas
* Armazenamento local dos dados

## Tecnologias

* Flutter
* Dart
* Shared Preferences
* Material 3

## Como executar

Instale as dependências:

```bash
flutter pub get
```

Execute o aplicativo:

```bash
flutter run
```

## Autora
Caroline Vitória - 3º Ano B - Sesi/Senai
