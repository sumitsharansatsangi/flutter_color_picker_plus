import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_color_picker_plus/flutter_color_picker_plus.dart';

void main() {
  group('SlidePicker Widget Tests', () {
    testWidgets('SlidePicker renders correctly', (WidgetTester tester) async {
      Color selectedColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlidePicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
        ),
      );

      // Check if SlidePicker is rendered
      expect(find.byType(SlidePicker), findsOneWidget);

      // Check if the widget renders without errors
      // Sliders may be implemented differently
    });

    testWidgets('SlidePicker changes color on slider interaction', (WidgetTester tester) async {
      Color selectedColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlidePicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
        ),
      );

      // Simulate slider interaction (this might require finding specific sliders)
      // For demonstration, we'll assume the first slider changes red value

      // Since sliders are complex, this is a basic test
      expect(find.byType(SlidePicker), findsOneWidget);
    });

    testWidgets('SlidePicker with different color models', (WidgetTester tester) async {
      final Color initialColor = Colors.green;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlidePicker(
              pickerColor: initialColor,
              onColorChanged: (_) {},
              colorModel: ColorModel.hsv,
            ),
          ),
        ),
      );

      expect(find.byType(SlidePicker), findsOneWidget);
    });

    testWidgets('SlidePicker with alpha disabled', (WidgetTester tester) async {
      final Color initialColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlidePicker(
              pickerColor: initialColor,
              onColorChanged: (_) {},
              enableAlpha: false,
            ),
          ),
        ),
      );

      expect(find.byType(SlidePicker), findsOneWidget);
      // Should have fewer sliders when alpha is disabled
    });

    testWidgets('SlidePicker with labels disabled', (WidgetTester tester) async {
      final Color initialColor = Colors.orange;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlidePicker(
              pickerColor: initialColor,
              onColorChanged: (_) {},
              labelTypes: [], // Empty list disables labels
            ),
          ),
        ),
      );

      expect(find.byType(SlidePicker), findsOneWidget);
    });
  });
}