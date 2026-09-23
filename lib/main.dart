// Caderno de Campo do Vale — PROJETO INICIAL
// Programação para Dispositivos Móveis · IF Goiano — Campus Ceres
//
// Este é o ponto de partida da aula de widgets de layout. O app já roda,
// mas a tela está praticamente vazia de propósito: você vai construí-la
// ao longo dos quatro ciclos, com o hot reload mostrando cada mudança.
//
// COMO RODAR (uma vez, no terminal, dentro desta pasta):
//   flutter create .        # gera as pastas nativas (android/, ios/...)
//   flutter pub get         # baixa as dependências
//   flutter run             # roda no dispositivo/emulador selecionado
//
// Depois, deixe o app rodando: salvar o arquivo aplica o hot reload.

import 'package:flutter/material.dart';
import 'tela_principal.dart';

// A mesma classe Talhao que você já conhece dos exercícios de Dart.
class Talhao {
  final String nome;
  final double areaHa;
  final String cultura;
  const Talhao({required this.nome, required this.areaHa, required this.cultura});
}

// Os dados da propriedade — a mesma lista dos exercícios.
const List<Talhao> talhoes = [
  Talhao(nome: 'Talhão 1', areaHa: 38.0, cultura: 'soja'),
  Talhao(nome: 'Talhão 2', areaHa: 24.5, cultura: 'milho'),
  Talhao(nome: 'Talhão 3', areaHa: 42.0, cultura: 'milho'),
  Talhao(nome: 'Talhão 4', areaHa: 31.2, cultura: 'soja'),
  Talhao(nome: 'Talhão 5', areaHa: 12.8, cultura: 'sorgo'),
  Talhao(nome: 'Talhão 6', areaHa: 19.4, cultura: 'milho'),
  Talhao(nome: 'Talhão 7', areaHa: 28.1, cultura: 'soja'),
  Talhao(nome: 'Talhão 8', areaHa: 15.6, cultura: 'milho'),
];

void main() => runApp(const CadernoApp());

class CadernoApp extends StatelessWidget {
  const CadernoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caderno de Campo do Vale',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E5631)),
        useMaterial3: true,
      ),
      home: const TelaPrincipal(),
    );
  }
}

class TelaResumo extends StatelessWidget {
  const TelaResumo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // AppBar: barra de título no topo da tela.
        title: const Text('Caderno de Campo do Vale'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),

      body: Container(
        // Padding interno: afasta o conteúdo das bordas da caixa.
        padding: const EdgeInsets.all(16),
        // Column: empilha os filhos na vertical, de cima para baixo.
        child: Column(
          // Alinha os filhos à esquerda (início da horizontal).
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFD5F5E3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const[
                  Text(
                    'Fazenda Talismã',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox: um espaço vazio de tamanho fixo. Aqui, respiro vertical.
                  SizedBox(height: 4),
                  Text(
                    'Goiania — GO',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),

            // Ciclo 2
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ===================================================== BUG 1
            // Esta Row tenta colocar dois cards largos lado a lado, mas
            // eles somados passam da largura da tela -> overflow amarelo.
            // CONSERTE: envolva CADA card em um Expanded, para que dividam
            // o espaço disponível em vez de exigir a largura cheia.
            Row(
              children: [
                Expanded(
                  child: _CardNumero(titulo: 'Talhões', valor: '${talhoes.length}'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _CardNumero(titulo: 'Atividades', valor: '14'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _CardNumero(titulo: 'Último', valor: 'há 3d'),
                ),
              ],
            ),

            // Enquanto o Expanded divide o espaço disponível igualmente entre os cards, o Flexible permite que defina uma proporção de espaço para cada card usando o parâmetro flex. No exemplo acima, o primeiro card ocupa 2/3 do espaço disponível, enquanto o segundo ocupa 1/3.

            const SizedBox(height: 16),

            // ===================================================== BUG 2
            // Este texto é muito longo e, dentro de uma Row, tenta ocupar
            // uma largura infinita -> overflow.
            // CONSERTE: envolva o Text em um Expanded para que ele quebre
            // a linha dentro do espaço que sobra.
            Row(
              children: const [
                Icon(Icons.info_outline, color: Color(0xFF1E5631)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Última sincronização feita há três dias — verifique o sinal '
                        'antes de sair para a lavoura para não perder registros.',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

            const SizedBox(height: 16),
            // Row: distribui os filhos na horizontal, lado a lado.
            Row(
              children: const [
                Text('Área total: ', style: TextStyle(fontSize: 16)),
                Text(
                  '96,4 ha',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Text('Responsável: ', style: TextStyle(fontSize: 16)),
                Text(
                  'Cantor Leonardo',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Ciclo 3
            Expanded(
              child: ListView.builder(
                itemCount: talhoes.length,
                itemBuilder: (context, indice) {
                  final talhao = talhoes[indice];
                  // ListTile: um item de lista pronto, com título, subtítulo e ícones.
                  final IconData iconeCultura = switch (talhao.cultura.trim().toLowerCase()){
                    'milho' => Icons.grain,
                    'soja' => Icons.eco,
                    'sorgo' => Icons.spa,
                    _ => Icons.grass,
                  };

                  return Card(
                    color: const Color(0xFFD5F5E3),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      leading: Icon(iconeCultura, color: const Color(0xFF1E5631)),
                      title: Text(
                        talhao.nome,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E5631),
                        ),
                      ),
                      subtitle: Text(
                        '${talhao.areaHa.toStringAsFixed(1).replaceAll('.', ',')} ha — ${talhao.cultura}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1E5631),
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Botão flutuante de nova atividade — sem função ainda.
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E5631),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Novo registro (em breve)')),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _CardNumero extends StatelessWidget {
  final String titulo;
  final String valor;
  const _CardNumero({required this.titulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFD5F5E3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(valor,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E5631)
              ),
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(titulo, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
