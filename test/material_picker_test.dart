import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_color_picker_plus/flutter_color_picker_plus.dart';

void main() {
  group('MaterialPicker Widget Tests', () {
    testWidgets('MaterialPicker renders correctly', (WidgetTester tester) async {
      Color selectedColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MaterialPicker(
              pickerColor: selectedColor,
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
      Color selectedColor = Colors.green;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MaterialPicker(
              pickerColor: selectedColor,
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
      Color selectedColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MaterialPicker(
              pickerColor: selectedColor,
              onColorChanged: (_) {},
              portraitOnly: true,
            ),
          ),
        ),
      );

      expect(find.byType(MaterialPicker), findsOneWidget);
    });

    testWidgets('MaterialPicker with onPrimaryChanged callback', (WidgetTester tester) async {
      Color? primaryColor = Colors.orange;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MaterialPicker(
              pickerColor: primaryColor,
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