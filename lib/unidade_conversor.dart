// =====================================================================
// Arquivo Auxiliar: unidade_conversor.dart
// =====================================================================
//
// Responsabilidade:
// Encapsular toda a lógica matemática de conversão de unidades agropecuárias
// em classes coesas, usando Orientação a Objetos (POO).
//
// Estrutura:
// - [ConversorMassa]  → Conversões entre Saca, Arroba, Kg, Tonelada
// - [ConversorArea]   → Conversões entre Alqueire Goiano, Hectare, Acre, m²
//
// Uso nos módulos de UI:
//   final resultado = ConversorMassa.toToneladas(valor: 10, de: UnidadeMassa.saca);
//   final resultado = ConversorArea.toHectares(valor: 2, de: UnidadeArea.alqueireGoiano);
//
// Fatores de Conversão (base em Quilograma e Hectare):
// - 1 Tonelada   = 1000 kg
// - 1 Saca       = 60   kg
// - 1 Arroba     = 15   kg
// - 1 Alqueire Goiano = 4.84   ha
// - 1 Acre       = 0.4047 ha
// - 1 Hectare    = 10000  m²
// =====================================================================

// ---------------------------------------------------------------------------
// Enumerações (Enum) — nomes canônicos das unidades suportadas
// ---------------------------------------------------------------------------

/// Unidades de massa suportadas pelo [ConversorMassa].
enum UnidadeMassa {
  quilograma,
  saca,
  arroba,
  tonelada,
}

/// Unidades de área suportadas pelo [ConversorArea].
enum UnidadeArea {
  hectare,
  alqueireGoiano,
  acre,
  metroQuadrado,
}

// ---------------------------------------------------------------------------
// Classe ConversorMassa
// ---------------------------------------------------------------------------

/// Converte valores entre as unidades de massa do agronegócio.
///
/// Todas as conversões passam internamente por **quilograma (kg)**
/// como unidade-base, garantindo precisão e fácil extensibilidade.
///
/// ### Exemplo de uso
/// ```dart
/// double resultado = ConversorMassa.toToneladas(
///   valor: 5,
///   de: UnidadeMassa.saca,
/// ); // → 0.3 t
/// ```
abstract final class ConversorMassa {
  // ---------------------------------------------------------------------------
  // Constantes de conversão (kg é a unidade-base)
  // ---------------------------------------------------------------------------
  static const double _kgPorTonelada = 1000.0;
  static const double _kgPorSaca = 60.0;
  static const double _kgPorArroba = 15.0;

  // ---------------------------------------------------------------------------
  // Passo 1 — Normalização: qualquer unidade → kg
  // ---------------------------------------------------------------------------

  /// Converte [valor] da unidade [de] para **quilogramas**.
  static double toQuilogramas({
    required double valor,
    required UnidadeMassa de,
  }) {
    switch (de) {
      case UnidadeMassa.quilograma:
        return valor;
      case UnidadeMassa.saca:
        return valor * _kgPorSaca;
      case UnidadeMassa.arroba:
        return valor * _kgPorArroba;
      case UnidadeMassa.tonelada:
        return valor * _kgPorTonelada;
    }
  }

  // ---------------------------------------------------------------------------
  // Passo 2 — Projeção: kg → unidade desejada
  // ---------------------------------------------------------------------------

  /// Converte [valor] da unidade [de] para **sacas**.
  static double toSacas({
    required double valor,
    required UnidadeMassa de,
  }) {
    final kg = toQuilogramas(valor: valor, de: de);
    return kg / _kgPorSaca;
  }

  /// Converte [valor] da unidade [de] para **arrobas**.
  static double toArrobas({
    required double valor,
    required UnidadeMassa de,
  }) {
    final kg = toQuilogramas(valor: valor, de: de);
    return kg / _kgPorArroba;
  }

  /// Converte [valor] da unidade [de] para **toneladas**.
  static double toToneladas({
    required double valor,
    required UnidadeMassa de,
  }) {
    final kg = toQuilogramas(valor: valor, de: de);
    return kg / _kgPorTonelada;
  }

  // ---------------------------------------------------------------------------
  // Método genérico — converte diretamente entre quaisquer duas unidades
  // ---------------------------------------------------------------------------

  /// Converta [valor] da unidade [de] para a unidade [para].
  ///
  /// Útil quando a unidade-destino é determinada em tempo de execução
  /// (ex.: estado de um widget).
  ///
  /// ```dart
  /// double res = ConversorMassa.converter(
  ///   valor: 3,
  ///   de:   UnidadeMassa.tonelada,
  ///   para: UnidadeMassa.saca,
  /// ); // → 50 sacas
  /// ```
  static double converter({
    required double valor,
    required UnidadeMassa de,
    required UnidadeMassa para,
  }) {
    if (de == para) return valor;
    final kg = toQuilogramas(valor: valor, de: de);
    switch (para) {
      case UnidadeMassa.quilograma:
        return kg;
      case UnidadeMassa.saca:
        return kg / _kgPorSaca;
      case UnidadeMassa.arroba:
        return kg / _kgPorArroba;
      case UnidadeMassa.tonelada:
        return kg / _kgPorTonelada;
    }
  }

  // ---------------------------------------------------------------------------
  // Utilitário: nome display → enum (bridge para a UI que usa Strings)
  // ---------------------------------------------------------------------------

  /// Mapeia o nome exibido na UI para o [UnidadeMassa] correspondente.
  ///
  /// Lança [ArgumentError] se [nome] não for reconhecido.
  static UnidadeMassa deNome(String nome) {
    switch (nome) {
      case 'Quilogramas':
        return UnidadeMassa.quilograma;
      case 'Sacas':
        return UnidadeMassa.saca;
      case 'Arrobas':
        return UnidadeMassa.arroba;
      case 'Toneladas':
        return UnidadeMassa.tonelada;
      default:
        throw ArgumentError('Unidade de massa desconhecida: "$nome"');
    }
  }
}

// ---------------------------------------------------------------------------
// Classe ConversorArea
// ---------------------------------------------------------------------------

/// Converte valores entre as unidades de área do agronegócio.
///
/// Todas as conversões passam internamente por **hectare (ha)**
/// como unidade-base.
///
/// ### Exemplo de uso
/// ```dart
/// double resultado = ConversorArea.toHectares(
///   valor: 1,
///   de: UnidadeArea.alqueireGoiano,
/// ); // → 4.84 ha
/// ```
abstract final class ConversorArea {
  // ---------------------------------------------------------------------------
  // Constantes de conversão (ha é a unidade-base)
  // ---------------------------------------------------------------------------
  static const double _haPorAlqueireGoiano = 4.84;
  static const double _haPorAcre = 0.4047;
  static const double _m2PorHectare = 10000.0;

  // ---------------------------------------------------------------------------
  // Passo 1 — Normalização: qualquer unidade → hectare
  // ---------------------------------------------------------------------------

  /// Converte [valor] da unidade [de] para **hectares**.
  static double toHectares({
    required double valor,
    required UnidadeArea de,
  }) {
    switch (de) {
      case UnidadeArea.hectare:
        return valor;
      case UnidadeArea.alqueireGoiano:
        return valor * _haPorAlqueireGoiano;
      case UnidadeArea.acre:
        return valor * _haPorAcre;
      case UnidadeArea.metroQuadrado:
        return valor / _m2PorHectare;
    }
  }

  // ---------------------------------------------------------------------------
  // Passo 2 — Projeção: ha → unidade desejada
  // ---------------------------------------------------------------------------

  /// Converte [valor] da unidade [de] para **alqueires goianos**.
  static double toAlqueiresGoianos({
    required double valor,
    required UnidadeArea de,
  }) {
    final ha = toHectares(valor: valor, de: de);
    return ha / _haPorAlqueireGoiano;
  }

  /// Converte [valor] da unidade [de] para **acres**.
  static double toAcres({
    required double valor,
    required UnidadeArea de,
  }) {
    final ha = toHectares(valor: valor, de: de);
    return ha / _haPorAcre;
  }

  /// Converte [valor] da unidade [de] para **metros quadrados**.
  static double toMetrosQuadrados({
    required double valor,
    required UnidadeArea de,
  }) {
    final ha = toHectares(valor: valor, de: de);
    return ha * _m2PorHectare;
  }

  // ---------------------------------------------------------------------------
  // Método genérico — converte diretamente entre quaisquer duas unidades
  // ---------------------------------------------------------------------------

  /// Converta [valor] da unidade [de] para a unidade [para].
  ///
  /// ```dart
  /// double res = ConversorArea.converter(
  ///   valor: 2,
  ///   de:   UnidadeArea.alqueireGoiano,
  ///   para: UnidadeArea.acre,
  /// );
  /// ```
  static double converter({
    required double valor,
    required UnidadeArea de,
    required UnidadeArea para,
  }) {
    if (de == para) return valor;
    final ha = toHectares(valor: valor, de: de);
    switch (para) {
      case UnidadeArea.hectare:
        return ha;
      case UnidadeArea.alqueireGoiano:
        return ha / _haPorAlqueireGoiano;
      case UnidadeArea.acre:
        return ha / _haPorAcre;
      case UnidadeArea.metroQuadrado:
        return ha * _m2PorHectare;
    }
  }

  // ---------------------------------------------------------------------------
  // Utilitário: nome display → enum (bridge para a UI que usa Strings)
  // ---------------------------------------------------------------------------

  /// Mapeia o nome exibido na UI para o [UnidadeArea] correspondente.
  ///
  /// Lança [ArgumentError] se [nome] não for reconhecido.
  static UnidadeArea deNome(String nome) {
    switch (nome) {
      case 'Hectares':
        return UnidadeArea.hectare;
      case 'Alqueires Goianos':
        return UnidadeArea.alqueireGoiano;
      case 'Acres':
        return UnidadeArea.acre;
      case 'Metros Quadrados':
        return UnidadeArea.metroQuadrado;
      default:
        throw ArgumentError('Unidade de área desconhecida: "$nome"');
    }
  }
}
