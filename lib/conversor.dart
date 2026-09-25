// =====================================================================
// Conversor de Unidade da Roça
// =====================================================================
//
// Objetivo:
// Desenvolver uma calculadora bidirecional que converta unidades de medida
// agropecuárias de Área e Massa.
//
// Estrutura de Interface (UI) Inspirada na Calculadora Samsung:
// - Navegação Superior: Uma `Row` de abas customizadas ("Área" e "Massa").
// - Navegação por Gestos: Integração de um `PageView` na área central,
//   permitindo ao usuário deslizar (swipe) a tela para mudar de aba.
// - Visores: Dois campos textuais numéricos (`TextField Outlined`) dispostos verticalmente.
// - Seleção de Unidades: O usuário poderá escolher a unidade clicando sobre
//   o rótulo, o que abrirá um `ModalBottomSheet` (menu deslizante inferior) com
//   a lista de opções.
//
// Comportamento e Estado (Construção/Lógica):f
// - Reatividade (`setState` e `onChanged`) para atualizar o outro campo instantaneamente.
// - Validação de entradas inválidas.
// - Botão "Limpar" para limpar a conversão ativa.
//
// Fatores de Conversão:
// - Massa: 1 Saca = 4 Arrobas (* 4 ou / 4)
// - Massa: 1 Tonelada = 1000 Quilogramas (* 1000 ou / 1000)
// - Massa: 1 Saca = 60 Quilogramas (* 60 ou / 60)
// - Massa: 1 Arroba = 15 Quilogramas (* 15 ou / 15)
// - Área: 1 Alqueire Goiano = 4.84 Hectares (* 4.84 ou / 4.84)
// - Área: 1 Hectare = 10000 Metros Quadrados (* 10000 ou / 10000)
// - Área: 1 Acre = 0.4047 Hectares (* 0.4047 ou / 0.4047)
// =====================================================================

import 'package:flutter/material.dart';

class TelaConversor extends StatefulWidget {
  const TelaConversor({super.key});

  @override
  State<TelaConversor> createState() => _TelaConversorState();
}

class _TelaConversorState extends State<TelaConversor> {
  // Índice do estado de navegação atual (0 = Área, 1 = Massa).
  int _abaSelecionada = 0;
  final List<String> _abas = ['Área', 'Massa'];

  // Instâncias de [TextEditingController] responsáveis pela gestão de estado
  // e leitura de entrada de texto dos widgets [TextField] (visores).
  final TextEditingController _topController = TextEditingController();
  final TextEditingController _bottomController = TextEditingController();

  @override
  void dispose() {
    // Desaloca os recursos em memória vinculados aos controladores
    // durante a destruição do ciclo de vida do widget.
    _topController.dispose();
    _bottomController.dispose();
    super.dispose();
  }

  // Método construtor de widget auxiliar para renderização dos visores de conversão.
  // Encapsula a lógica de estilização do [TextField] para maximizar o reuso de código.
  Widget _buildVisor({
    required TextEditingController controller,
    required String labelText,
    required String suffixText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E5631),
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Color(0xFF1E5631),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixText: suffixText,
          suffixStyle: const TextStyle(fontSize: 20, color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF1E5631), width: 2.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor da Roça'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seletor de Abas
          Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 0.0),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_abas.length, (index) {
                final isSelected = _abaSelecionada == index;
                return GestureDetector(
                  onTap: () {
                    // Previne reconstruções desnecessárias da árvore de widgets
                    if (_abaSelecionada != index) {
                      setState(() {
                        // Atualiza o índice do seletor e invalida o estado atual dos visores
                        _abaSelecionada = index;
                        _topController.clear();
                        _bottomController.clear();
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFD5F5E3)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0),
                      border: isSelected
                          ? Border.all(
                              color: const Color(0xFFD5F5E3),
                              width: 1.0,
                            )
                          : Border.all(color: Colors.transparent, width: 1.0),
                    ),
                    child: Text(
                      _abas[index],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFF1E5631)
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const Divider(),

          // Visores do conversor
          Expanded(
            // Utiliza [ListView] para prover comportamento de scroll dinâmico,
            // prevenindo overflows de layout durante a exibição do teclado virtual.
            child: ListView(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
              children: [
                _buildVisor(
                  controller: _topController,
                  labelText: _abaSelecionada == 0 ? 'Hectares' : 'Sacas',
                  suffixText: _abaSelecionada == 0 ? 'ha' : 'scs',
                ),

                const SizedBox(height: 4.0),

                _buildVisor(
                  controller: _bottomController,
                  labelText: _abaSelecionada == 0
                      ? 'Alqueires Goianos'
                      : 'Arrobas',
                  suffixText: _abaSelecionada == 0 ? 'alq go' : '@',
                ),

                const SizedBox(height: 24.0),

                // Botão Limpar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Invalida o buffer dos controladores de texto, redefinindo
                      // a interface para o seu estado inicial vazio.
                      _topController.clear();
                      _bottomController.clear();
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Limpar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1E5631),
                      side: const BorderSide(
                        color: Color(0xFF1E5631),
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
