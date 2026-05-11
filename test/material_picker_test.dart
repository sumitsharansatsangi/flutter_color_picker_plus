import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_color_picker_plus/flutter_color_picker_plus.dart';

void main() {
  group('MaterialPicker Widget Tests', () {
    testWidgets('MaterialPicker renders correctly', (WidgetTester tester) async {
      final Color initialColor = Colors.blue;
      Color selectedColor = initialColor;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MaterialPicker(
              pickerColor: initialColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
        ),
      );

      // Check if MaterialPicker is rendered
      expect(find.byType(MaterialPicker), findsOneWidget);

      // Check if the widget renders without errors
    });



    testWidgets('MaterialPicker with labels enabled', (WidgetTester tester) async {
      final Color initialColor = Colors.green;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MaterialPicker(
              pickerColor: initialColor,
              onColorChanged: (_) {},
              enableLabel: true,
            ),
          ),
        ),
      );

      expect(find.byType(MaterialPicker), findsOneWidget);
      // Labels should be present
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('MaterialPicker in portrait only mode', (WidgetTester tester) async {
      final Color initialColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MaterialPicker(
              pickerColor: initialColor,
              onColorChanged: (_) {},
              portraitOnly: true,
            ),
          ),
        ),
      );

      expect(find.byType(MaterialPicker), findsOneWidget);
    });

    testWidgets('MaterialPicker with onPrimaryChanged callback', (WidgetTester tester) async {
      final Color initialColor = Colors.orange;
      Color? primaryColor;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MaterialPicker(
              pickerColor: initialColor,
              onColorChanged: (_) {},
              onPrimaryChanged: (color) {
                primaryColor = color;
              },
            ),
          ),
        ),
      );

      expect(find.byType(MaterialPicker), findsOneWidget);
    });
  });
}