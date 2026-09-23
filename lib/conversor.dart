// =====================================================================
// Conversor de Unidade da Roça
// =====================================================================
// 
// Objetivo: 
// Desenvolver uma calculadora bidirecional que converta unidades de medida 
// de Área: Hectares (ha) e Alqueires Goianos (alq go); e Massa: Sacas (scs) e Arrobas (@).
//
// Estrutura de Interface (UI):
// - Navegação: Um seletor customizado no topo da tela para separar e alternar  
//   o estado entre as abas "Área" e "Massa".
// - Visores: Dois campos `TextField Outlined` editáveis dispostos verticalmente.
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
  int _abaSelecionada = 0; // 0 para Área, 1 para Massa
  final List<String> _abas = ['Área', 'Massa'];

  // Controladores dos visores
  final TextEditingController _topController = TextEditingController();
  final TextEditingController _bottomController = TextEditingController();

  @override
  void dispose() {
    _topController.dispose();
    _bottomController.dispose();
    super.dispose();
  }

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
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Color(0xFF1E5631)),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Color(0xFF1E5631), fontSize: 16, fontWeight: FontWeight.bold),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixText: suffixText,
          suffixStyle: const TextStyle(fontSize: 20, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF1E5631), width: 2.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                    if (_abaSelecionada != index) {
                      setState(() {
                        _abaSelecionada = index;
                        _topController.clear();
                        _bottomController.clear();
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? const Color(0xFFD5F5E3)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0),
                      border: isSelected 
                          ? Border.all(color: const Color(0xFFD5F5E3), width: 1.0)
                          : Border.all(color: Colors.transparent, width: 1.0),
                    ),
                    child: Text(
                      _abas[index],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? const Color(0xFF1E5631) : Colors.grey.shade600,
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
                  labelText: _abaSelecionada == 0 ? 'Alqueires Goianos' : 'Arrobas',
                  suffixText: _abaSelecionada == 0 ? 'alq go' : '@',
                ),

                const SizedBox(height: 24.0),

                // Botão Limpar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _topController.clear();
                      _bottomController.clear();
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Limpar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1E5631), 
                      side: const BorderSide(color: Color(0xFF1E5631), width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
