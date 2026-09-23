// =====================================================================
// Conversor de Unidade da Roça
// =====================================================================
// 
// Objetivo: 
// Desenvolver uma calculadora bidirecional que converta unidades de medida 
// de Área: Hectares (ha) e Alqueires Goianos (alq. go); e Massa: Sacas (scs) e Arrobas (@).
//
// Estrutura de Interface (UI):
// - Navegação: Um seletor customizado no topo da tela para separar e alternar  
//   o estado entre as abas "Área" e "Massa".
// - Visores: Dois campos `TextField` editáveis dispostos verticalmente.
//   - O texto interior deve ser alinhado à direita (`textAlign: TextAlign.right`).
//   - Cada campo deve exibir um seletor de opções contendo a sua unidade de medida.
// 
// Comportamento e Estado:
// - Reatividade (`setState` e `onChanged`): Ao digitar um valor em qualquer um 
//   dos campos, o evento `onChanged` deve disparar o cálculo imediato, atualizando 
//   o outro campo automaticamente em tempo real (via de mão dupla).
// - Botão "Limpar": Ação para redefinir o estado da tela, esvaziando ambos os campos.
// - Validação: Realizar parse da entrada; caso o valor inserido seja inválido 
//   ou não numérico, um aviso claro deve ser exibido ao usuário na interface.
//
// Fatores de Conversão:
// - Massa: 1 Saca = 4 Arrobas (* 4 ou / 4)
// - Área: 1 Alqueire Goiano = 4.84 Hectares (* 4.84 ou / 4.84)
// =====================================================================

import 'package:flutter/material.dart';

class TelaConversor extends StatefulWidget {
  const TelaConversor({super.key});

  @override
  State<TelaConversor> createState() => _TelaConversorState();
}

class _TelaConversorState extends State<TelaConversor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor da Roça'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'O conversor será construído aqui.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
