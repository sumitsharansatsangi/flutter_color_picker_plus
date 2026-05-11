// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Color Picker';

  @override
  String get colorPickerTitle => 'Select a Color';

  @override
  String get rgbLabel => 'RGB';

  @override
  String get hsvLabel => 'HSV';

  @override
  String get hslLabel => 'HSL';

  @override
  String get cmykLabel => 'CMYK';

  @override
  String get labLabel => 'LAB';

  @override
  String get hexLabel => 'Hex';

  @override
  String get alphaLabel => 'Alpha';

  @override
  String get redLabel => 'Red';

  @override
  String get greenLabel => 'Green';

  @override
  String get blueLabel => 'Blue';

  @override
  String get hueLabel => 'Hue';

  @override
  String get saturationLabel => 'Saturation';

  @override
  String get valueLabel => 'Value';

  @override
  String get lightnessLabel => 'Lightness';

  @override
  String get cyanLabel => 'Cyan';

  @override
  String get magentaLabel => 'Magenta';

  @override
  String get yellowLabel => 'Yellow';

  @override
  String get blackLabel => 'Black';

  @override
  String get lLabel => 'L';

  @override
  String get aLabel => 'A';

  @override
  String get bLabel => 'B';

  @override
  String get colorPickerHint =>
      'Use the color area and sliders to select a color';

  @override
  String get colorSelected => 'Color selected';

  @override
  String colorChanged(Object color) {
    return 'Color changed to $color';
  }

  @override
  String get invalidHex => 'Invalid hex color format';
}
