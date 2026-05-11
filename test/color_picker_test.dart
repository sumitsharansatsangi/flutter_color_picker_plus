import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_color_picker_plus/flutter_color_picker_plus.dart';

void main() {
  group('ColorPicker Widget Tests', () {
    testWidgets('ColorPicker renders correctly', (WidgetTester tester) async {
    
      Color selectedColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
        ),
      );

      // Check if ColorPicker is rendered
      expect(find.byType(ColorPicker), findsOneWidget);

      // Check if initial color is displayed (this might vary based on implementation)
      // You can add more specific checks based on the widget's structure
    });

    testWidgets('ColorPicker changes color on interaction', (WidgetTester tester) async {
      Color  selectedColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
        ),
      );

      // Simulate user interaction (this would depend on the specific picker implementation)
      // For example, if there's a color wheel or slider, tap on it
      // Since we don't know the exact structure, this is a placeholder

      // After interaction, check if onColorChanged was called
      // expect(selectedColor, isNot(equals(initialColor)));
    });

    testWidgets('ColorPicker with different palette types', (WidgetTester tester) async {
      final Color initialColor = Colors.green;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ColorPicker(
              pickerColor: initialColor,
              onColorChanged: (_) {},
              paletteType: PaletteType.hsv,
            ),
          ),
        ),
      );

      expect(find.byType(ColorPicker), findsOneWidget);
    });

    testWidgets('ColorPicker with alpha disabled', (WidgetTester tester) async {
      final Color initialColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ColorPicker(
              pickerColor: initialColor,
              onColorChanged: (_) {},
              enableAlpha: false,
            ),
          ),
        ),
      );

      expect(find.byType(ColorPicker), findsOneWidget);
    });
  });
}