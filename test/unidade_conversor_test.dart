import 'package:flutter_test/flutter_test.dart';
import 'package:caderno_de_campo_do_vale_conversor/unidade_conversor.dart';

void main() {
  test('1 saca = 4 arrobas', () {
    expect(
      ConversorMassa.converter(
          valor: 1, de: UnidadeMassa.saca, para: UnidadeMassa.arroba),
      closeTo(4, 1e-9),
    );
  });

  test('1 saca = 0,06 tonelada', () {
    expect(
      ConversorMassa.converter(
          valor: 1, de: UnidadeMassa.saca, para: UnidadeMassa.tonelada),
      closeTo(0.06, 1e-9),
    );
  });

  test('1 alqueire goiano = 4,84 hectares', () {
    expect(
      ConversorArea.converter(
          valor: 1, de: UnidadeArea.alqueireGoiano, para: UnidadeArea.hectare),
      closeTo(4.84, 1e-9),
    );
  });

  test('1 hectare = 10.000 m²', () {
    expect(
      ConversorArea.converter(
          valor: 1, de: UnidadeArea.hectare, para: UnidadeArea.metroQuadrado),
      closeTo(10000, 1e-9),
    );
  });
}
