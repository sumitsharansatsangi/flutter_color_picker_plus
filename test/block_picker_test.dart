import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_color_picker_plus/flutter_color_picker_plus.dart';

void main() {
  group('BlockPicker Widget Tests', () {
    testWidgets('BlockPicker renders correctly', (WidgetTester tester) async {
      Color selectedColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlockPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
        ),
      );

      // Check if BlockPicker is rendered
      expect(find.byType(BlockPicker), findsOneWidget);

      // Check if colors are displayed (should have multiple color blocks)
      expect(find.byType(GestureDetector), findsWidgets); // Color blocks are wrapped in GestureDetector
    });

    testWidgets('BlockPicker changes color on tap', (WidgetTester tester) async {
      final Color initialColor = Colors.red;
      Color selectedColor = initialColor;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlockPicker(
              pickerColor: initialColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
        ),
      );

      // Tap on a different color block
      final gestureDetectors = find.byType(GestureDetector);
      if (gestureDetectors.evaluate().length > 1) {
        await tester.tap(gestureDetectors.at(1)); // Tap the second one
        await tester.pump();
        // Check if onColorChanged was called (color should change)
        expect(selectedColor, isNot(equals(initialColor)));
      }
    });

    testWidgets('BlockPicker with custom colors', (WidgetTester tester) async {
      final List<Color> customColors = [Colors.red, Colors.green, Colors.blue];
      final Color initialColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlockPicker(
              pickerColor: initialColor,
              onColorChanged: (_) {},
              availableColors: customColors,
            ),
          ),
        ),
      );

      expect(find.byType(BlockPicker), findsOneWidget);
      // Should have 3 color blocks
      expect(find.byType(GestureDetector), findsNWidgets(3));
    });

    testWidgets('BlockPicker with useInShowDialog false', (WidgetTester tester) async {
      final Color initialColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlockPicker(
              pickerColor: initialColor,
              onColorChanged: (_) {},
              useInShowDialog: false,
            ),
          ),
        ),
      );

      expect(find.byType(BlockPicker), findsOneWidget);
    });
  });
}