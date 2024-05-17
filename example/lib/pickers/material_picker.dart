import 'package:flutter/material.dart';
import 'package:flutter_color_picker_plus/flutter_color_picker_plus.dart';

class MaterialColorPickerExample extends StatefulWidget {
  const MaterialColorPickerExample({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
  });

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  @override
  State<MaterialColorPickerExample> createState() =>
      _MaterialColorPickerExampleState();
}

class _MaterialColorPickerExampleState
    extends State<MaterialColorPickerExample> {
  bool _enableLabel = true;
  bool _portraitOnly = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: SingleChildScrollView(
                        child: MaterialPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          enableLabel: _enableLabel,
                          portraitOnly: _portraitOnly,
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
              child: Text(
                'Kiss Me with Your Finger',
                style: TextStyle(
                    color: useWhiteForeground(widget.pickerColor)
                        ? Colors.white
                        : Colors.black),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(25),
                      content: SingleChildScrollView(
                        child: Text(
                          '''
MaterialPicker(
  pickerColor: color,
  onColorChanged: changeColor,
  enableLabel: $_enableLabel,
  portraitOnly: $_portraitOnly,
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
              child: Icon(Icons.code,
                  color: useWhiteForeground(widget.pickerColor)
                      ? Colors.white
                      : Colors.black),
            ),
          ],
        ),
        SwitchListTile(
          title: const Text('Enable Label in Portrait Mode'),
          value: _enableLabel,
          onChanged: (bool value) =>
              setState(() => _enableLabel = !_enableLabel),
        ),
        SwitchListTile(
          title: const Text('Apply Portrait layout to Landscape Mode'),
          value: _portraitOnly,
          onChanged: (bool value) =>
              setState(() => _portraitOnly = !_portraitOnly),
        ),
      ],
    );
  }
}
