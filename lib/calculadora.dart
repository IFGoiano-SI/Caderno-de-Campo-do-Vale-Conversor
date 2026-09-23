// Calculadora de Receita da Lavoura — PROJETO INICIAL (esqueleto)
// Aula prática guiada · Programação para Dispositivos Móveis
// IF Goiano — Campus Ceres · Prof. Dr. Paulo César Ferreira Melo
//
// O QUE VAMOS CONSTRUIR
// Uma tela em que o produtor informa a área do talhão (ha), a
// produtividade esperada (sacas por ha) e a cotação da saca (R$), e o
// app calcula a receita bruta estimada: área × produtividade × cotação.
//
// COMO USAR ESTE ESQUELETO
// O professor conduz a aula passo a passo. Cada trecho a completar está
// marcado com "PASSO N". Vá preenchendo na ordem, salvando e vendo
// o hot reload aplicar cada mudança. O que já está pronto é só o mínimo
// para o app rodar desde o primeiro minuto.
//
// COMO RODAR (uma vez, no terminal, dentro desta pasta):
//   flutter create .
//   flutter pub get
//   flutter run

import 'package:flutter/material.dart';

// =====================================================================
// PASSO 2 — A tela com estado  (JÁ PRONTO)
// É StatefulWidget porque o conteúdo muda: campos digitados e resultado.
// =====================================================================
class TelaCalculadora extends StatefulWidget {
  const TelaCalculadora({super.key});

  @override
  State<TelaCalculadora> createState() => _TelaCalculadoraState();
}

class _TelaCalculadoraState extends State<TelaCalculadora> {
  // -------------------------------------------------------------------
  // PASSO 3 — Crie um TextEditingController para cada campo:
  //   _areaController, _produtividadeController, _cotacaoController.
  // Exemplo: final _areaController = TextEditingController();
  // -------------------------------------------------------------------

  final _areaController = TextEditingController();
  final _produtividadeController = TextEditingController();
  final _cotacaoController = TextEditingController();

  // -------------------------------------------------------------------
  // PASSO 4 — Crie o estado do resultado:
  //   double? _receita;   (começa nulo: ainda não há cálculo)
  //   String? _erro;      (mensagem de validação, quando houver)
  // -------------------------------------------------------------------

  double? _receita;
  String? _erro;

  // -------------------------------------------------------------------
  // PASSO 6 — A função que calcula.
  // Leia os três campos (trocando ',' por '.' antes de converter),
  // valide, e atualize _receita e _erro DENTRO de setState().
  //
  // void _calcular() {
  //   final area = double.tryParse(_areaController.text.replaceAll(',', '.'));
  //   ...
  //   setState(() { ... });
  // }
  // -------------------------------------------------------------------

  void _calcular() {
    final area = double.tryParse(_areaController.text.replaceAll(',', '.'));
    final produtividade = double.tryParse(_produtividadeController.text.replaceAll(',', '.'));
    final cotacao = double.tryParse(_cotacaoController.text.replaceAll(',', '.'));
    if (area == null || produtividade == null || cotacao == null) {
      setState(() {
        _receita = null;
        _erro = 'Preencha todos os campos com números válidos';
      });
      return;
    }
    if (area <= 0 || produtividade <= 0 || cotacao <= 0) {
      setState(() {
        _receita = null;
        _erro = 'Preencha todos os campos com números maiores que zero';
      });
      return;
    }
    setState(() {
      _receita = area * produtividade * cotacao;
      _erro = null;
    });
  }

  // -------------------------------------------------------------------
  // PASSO 9 — A função que limpa os campos e o resultado.
  // -------------------------------------------------------------------

  void _limpar() {
    _areaController.clear();
    _produtividadeController.clear();
    _cotacaoController.clear();

    setState(() {
      _receita = null;
      _erro = null;
    });
  }

  // -------------------------------------------------------------------
  // PASSO 8 — Libere os controladores no dispose().
  // @override
  // void dispose() { ... ; super.dispose(); }
  // -------------------------------------------------------------------

  @override
  void dispose() {
    _areaController.dispose();
    _produtividadeController.dispose();
    _cotacaoController.dispose();
    super.dispose();
  }

  // Formata um número no padrão brasileiro. (JÁ PRONTO — não precisa mexer)
  String _reais(double valor) {
    final fixo = valor.toStringAsFixed(2);
    final partes = fixo.split('.');
    final inteira = partes[0];
    final decimal = partes[1];
    final buffer = StringBuffer();
    for (int k = 0; k < inteira.length; k++) {
      if (k > 0 && (inteira.length - k) % 3 == 0) buffer.write('.');
      buffer.write(inteira[k]);
    }
    return 'R\$ ${buffer.toString()},$decimal';
  }

  // =====================================================================
  // PASSO 5 — A interface
  // =====================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receita da Lavoura'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Estime a receita bruta do talhão',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Informe os dados da cultura e toque em Calcular.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // ---------------------------------------------------------------
            // PASSO 3 (continuação) — Adicione aqui os três campos, um
            // por linha, usando o widget _CampoNumero (já pronto lá embaixo),
            // separados por SizedBox(height: 16). Ligue cada um ao seu
            // controlador.
            //
            // _CampoNumero(
            //   controlador: _areaController,
            //   rotulo: 'Área do talhão (ha)',
            //   icone: Icons.crop_square,
            // ),
            // ---------------------------------------------------------------

            _CampoNumero(
              controlador: _areaController,
              rotulo: 'Área do talhão (ha)',
              icone: Icons.crop_square,
            ),

            const SizedBox(height: 16),

            _CampoNumero(
              controlador: _produtividadeController,
              rotulo: 'Produtividade (sacas/ha)',
              icone: Icons.eco,
            ),

            const SizedBox(height: 16),

            _CampoNumero(
              controlador: _cotacaoController,
              rotulo: 'Cotação da saca (R\$)',
              icone: Icons.attach_money,
            ),

            const SizedBox(height: 24),

            // ---------------------------------------------------------------
            // PASSO 7 — Adicione os botões Calcular e Limpar numa Row.
            // O Calcular ocupa a maior parte (Expanded) e chama _calcular;
            // o Limpar chama _limpar.
            // ---------------------------------------------------------------

            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _calcular,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Calcular'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF1E5631),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                OutlinedButton(
                  onPressed: _limpar,
                  child: const Text('Limpar'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1E5631)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ---------------------------------------------------------------
            // PASSO 10 — Mostre o resultado. Use o widget _AreaResultado
            // (já pronto), passando _receita, _erro e a função _reais.
            //
            // _AreaResultado(receita: _receita, erro: _erro, formatar: _reais),
            // ---------------------------------------------------------------

            _AreaResultado(receita: _receita, erro: _erro, formatar: _reais),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// Campo de número reutilizável.  (JÁ PRONTO — pronto para usar no Passo 3)
// =====================================================================
class _CampoNumero extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final IconData icone;

  const _CampoNumero({
    required this.controlador,
    required this.rotulo,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: rotulo,
        prefixIcon: Icon(icone, color: const Color(0xFF1E5631)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

// =====================================================================
// Área de resultado.  (JÁ PRONTO — pronto para usar no Passo 10)
// Mostra o erro, o resultado em destaque, ou nada.
// =====================================================================
class _AreaResultado extends StatelessWidget {
  final double? receita;
  final String? erro;
  final String Function(double) formatar;

  const _AreaResultado({
    required this.receita,
    required this.erro,
    required this.formatar,
  });

  @override
  Widget build(BuildContext context) {
    if (erro != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFDECEA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFB3261E)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(erro!,
                  style: const TextStyle(color: Color(0xFFB3261E))),
            ),
          ],
        ),
      );
    }

    if (receita == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFD5F5E3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text('Receita bruta estimada',
              style: TextStyle(fontSize: 14, color: Colors.black54)),
          const SizedBox(height: 8),
          Text(
            formatar(receita!),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5631),
            ),
          ),
        ],
      ),
    );
  }
}
