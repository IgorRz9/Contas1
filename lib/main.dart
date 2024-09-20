import 'package:flutter/material.dart';
import 'package:myapp/Telas/tela_inicial.dart';

void main() {
  runApp(MeuAplicativo());
}

class MeuAplicativo extends StatefulWidget {
  @override
  _MeuAplicativoState createState() => _MeuAplicativoState();

  static _MeuAplicativoState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MeuAplicativoState>();
  }
}

class _MeuAplicativoState extends State<MeuAplicativo> {
  ThemeMode _themeMode = ThemeMode.light; // Tema padrão

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Financeira',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode, // Use a variável de tema atual
      home: TelaInicial(),
      debugShowCheckedModeBanner: false,
    );
  }
}