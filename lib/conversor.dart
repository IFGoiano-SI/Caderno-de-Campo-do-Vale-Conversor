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
//   o rótulo do próprio campo, o que abrirá um `PopupMenuButton` suspenso com
//   a lista de opções, idêntico à calculadora da Samsung.
//
// Comportamento e Estado (Construção/Lógica):
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

  // Controlador para o swipe (gesto de arrastar)
  late PageController _pageController;

  // Estados puramente visuais das unidades selecionadas (sem lógica matemática)
  String _unidadeTopArea = 'Hectares';
  String _unidadeBottomArea = 'Alqueires Goianos';
  String _unidadeTopMassa = 'Sacas';
  String _unidadeBottomMassa = 'Arrobas';

  // Opções para o BottomSheet
  final List<String> _opcoesArea = [
    'Hectares',
    'Alqueires Goianos',
    'Acres',
    'Metros Quadrados',
  ];
  final List<String> _opcoesMassa = [
    'Sacas',
    'Arrobas',
    'Quilogramas',
    'Toneladas',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _abaSelecionada);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _topController.dispose();
    _bottomController.dispose();
    super.dispose();
  }

  String _obterSigla(String unidade) {
    switch (unidade) {
      case 'Hectares': return 'ha';
      case 'Alqueires Goianos': return 'alq go';
      case 'Acres': return 'ac';
      case 'Metros Quadrados': return 'm²';
      case 'Sacas': return 'scs';
      case 'Arrobas': return '@';
      case 'Quilogramas': return 'kg';
      case 'Toneladas': return 't';
      default: return '';
    }
  }

  // Constrói o agrupamento visual principal de conversão (Label interativo + Campo Numérico).
  // O construtor (Matheus) deverá acoplar o evento 'onChanged' no TextField interno deste widget.
  Widget _buildVisor({
    required TextEditingController controller,
    required String selectedUnit,
    required List<String> availableUnits,
    required ValueChanged<String> onUnitChanged,
  }) {
    final symbol = _obterSigla(selectedUnit);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
              floatingLabelBehavior: FloatingLabelBehavior.never,
              // Fixa a sigla no canto direito para garantir visibilidade contínua.
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      symbol,
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
            ),
          ),
        ),
        // Posiciona o botão exatamente sobre a borda superior do TextField
        Positioned(
          left: 12.0, // Alinha horizontalmente com o conteúdo interno
          top: 0.0, // Centraliza perfeitamente em cima da linha do TextField usando top=0
          child: Container(
            // Cor de fundo idêntica à tela para "apagar" a linha da borda perfeitamente
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
              ), // Margem de respiro para o texto
              child: PopupMenuButton<String>(
                padding: EdgeInsets.zero, // Zera o padding padrão do componente
                initialValue: selectedUnit,
                onSelected: onUnitChanged,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                offset: const Offset(0, 24),
                itemBuilder: (context) {
                  return availableUnits.map((unit) {
                    final isSelected = unit == selectedUnit;
                    return PopupMenuItem<String>(
                      value: unit,
                      child: Text(
                        unit,
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? const Color(0xFF1E5631)
                              : Colors.black87,
                        ),
                      ),
                    );
                  }).toList();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedUnit,
                      style: const TextStyle(
                        color: Color(0xFF1E5631),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2.0),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF1E5631),
                      size: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  // Monta a estrutura em lista para cada página do PageView, contendo os dois visores
  // (superior e inferior) correspondentes à grandeza selecionada (Área ou Massa).
  Widget _buildAbaConteudo({required bool isArea}) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildVisor(
          controller: _topController,
          selectedUnit: isArea ? _unidadeTopArea : _unidadeTopMassa,
          availableUnits: isArea ? _opcoesArea : _opcoesMassa,
          onUnitChanged: (novaUnidade) {
            setState(() {
              if (isArea) {
                _unidadeTopArea = novaUnidade;
              } else {
                _unidadeTopMassa = novaUnidade;
              }
            });
          },
        ),

        const SizedBox(height: 16.0),

        _buildVisor(
          controller: _bottomController,
          selectedUnit: isArea ? _unidadeBottomArea : _unidadeBottomMassa,
          availableUnits: isArea ? _opcoesArea : _opcoesMassa,
          onUnitChanged: (novaUnidade) {
            setState(() {
              if (isArea) {
                _unidadeBottomArea = novaUnidade;
              } else {
                _unidadeBottomMassa = novaUnidade;
              }
            });
          },
        ),

        const SizedBox(height: 24.0),

        OutlinedButton(
          onPressed: () {
            _topController.clear();
            _bottomController.clear();
          },
          child: const Text('Limpar'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF1E5631),
            side: const BorderSide(color: Color(0xFF1E5631), width: 1.0),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            textStyle: const TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ],
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
          // 1. Barra Superior de Abas (Navegação Visual)
          // Linha com botões customizados de alto contraste para toque rápido.
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
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
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

          // 2. Área Central de Conversão (Navegação por Swipe)
          // Permite que o usuário arraste a tela lateralmente para trocar a página ativa.
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _abaSelecionada = index;
                  _topController.clear();
                  _bottomController.clear();
                });
              },
              children: [
                _buildAbaConteudo(isArea: true),
                _buildAbaConteudo(isArea: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
