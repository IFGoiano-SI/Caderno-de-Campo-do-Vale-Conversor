import 'package:flutter/material.dart';
import 'main.dart'; // Para acessar a TelaResumo
import 'calculadora.dart'; // Para acessar a TelaCalculadora
import 'conversor.dart'; // Para acessar a TelaConversor

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color(0xFFD5F5E3), // Verde claro seguindo a identidade visual
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Color(0xFF1E5631)),
            icon: Icon(Icons.home_outlined, color: Color(0xFF1E5631)),
            label: 'Resumo',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calculate, color: Color(0xFF1E5631)),
            icon: Icon(Icons.calculate_outlined, color: Color(0xFF1E5631)),
            label: 'Receita',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.sync_alt, color: Color(0xFF1E5631)),
            icon: Icon(Icons.sync_alt, color: Color(0xFF1E5631)),
            label: 'Medidas',
          ),
        ],
      ),
      body: <Widget>[
        const TelaResumo(),
        const TelaCalculadora(),
        const TelaConversor(),
      ][currentPageIndex],
    );
  }
}
