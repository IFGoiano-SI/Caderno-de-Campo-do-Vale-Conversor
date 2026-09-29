// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:caderno_de_campo_do_vale_conversor/main.dart';

void main() {
  testWidgets('O app deve renderizar corretamente', (
    WidgetTester tester,
  ) async {
    // Constrói o app
    await tester.pumpWidget(const CadernoApp());

    // Verifica se a tela principal abriu buscando pelo texto 'Resumo' da barra de navegação
    expect(find.text('Resumo'), findsWidgets);
  });
}
