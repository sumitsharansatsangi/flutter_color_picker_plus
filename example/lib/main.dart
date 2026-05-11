import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_color_picker_plus/flutter_color_picker_plus.dart';
import 'package:flutter_color_picker_plus/l10n/app_localizations.dart';

import './pickers/block_picker.dart';
import './pickers/hsv_picker.dart';
import './pickers/material_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('es', ''), // Spanish
      ],
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool lightTheme = true;
  Color currentColor = Colors.amber;
  List<Color> currentColors = [Colors.yellow, Colors.green];
  List<Color> colorHistory = [];

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);

  @override
  Widget build(BuildContext context) {
    final foregroundColor = useWhiteForeground(currentColor)
        ? Colors.white
        : Colors.black;
    return AnimatedTheme(
      data: lightTheme ? ThemeData.light() : ThemeData.dark(),
      child: Builder(
        builder: (context) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () => setState(() => lightTheme = !lightTheme),
                icon: Icon(
                  lightTheme
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                ),
                label: Text(lightTheme ? 'Night' : '  Day '),
                backgroundColor: currentColor,
                foregroundColor: foregroundColor,
                elevation: 15,
              ),
              appBar: AppBar(
                title: const Text('Flutter Color Picker Example'),
                backgroundColor: currentColor,
                foregroundColor: foregroundColor,
                bottom: TabBar(
                  labelColor: foregroundColor,
                  tabs: const <Widget>[
                    Tab(text: 'HSV/HSL/RGB'),
                    Tab(text: 'Material'),
                    Tab(text: 'Blocky'),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  HSVColorPickerExample(
                    pickerColor: currentColor,
                    onColorChanged: changeColor,
                    colorHistory: colorHistory,
                    onHistoryChanged: (List<Color> colors) =>
                        colorHistory = colors,
                  ),
                  MaterialColorPickerExample(
                    pickerColor: currentColor,
                    onColorChanged: changeColor,
                  ),
                  BlockColorPickerExample(
                    pickerColor: currentColor,
                    onColorChanged: changeColor,
                    pickerColors: currentColors,
                    onColorsChanged: changeColors,
                    colorHistory: colorHistory,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
