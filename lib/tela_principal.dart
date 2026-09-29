import 'package:flutter/material.dart';
import 'dart:math' as math;
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
        destinations: <Widget>[
          const NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Color(0xFF1E5631)),
            icon: Icon(Icons.home, color: Color(0xFF1E5631)),
            label: 'Resumo',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.calculate, color: Color(0xFF1E5631)),
            icon: Icon(Icons.calculate, color: Color(0xFF1E5631)),
            label: 'Receita',
          ),
          NavigationDestination(
            selectedIcon: Transform.rotate(
              angle: math.pi / 4, // 45 graus
              child: const Icon(Icons.straighten, color: Color(0xFF1E5631)),
            ),
            icon: Transform.rotate(
              angle: math.pi / 4, // 45 graus
              child: const Icon(Icons.straighten, color: Color(0xFF1E5631)),
            ),
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
