// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Selector de Color';

  @override
  String get colorPickerTitle => 'Selecciona un Color';

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
  String get alphaLabel => 'Alfa';

  @override
  String get redLabel => 'Rojo';

  @override
  String get greenLabel => 'Verde';

  @override
  String get blueLabel => 'Azul';

  @override
  String get hueLabel => 'Matiz';

  @override
  String get saturationLabel => 'Saturación';

  @override
  String get valueLabel => 'Valor';

  @override
  String get lightnessLabel => 'Luminosidad';

  @override
  String get cyanLabel => 'Cian';

  @override
  String get magentaLabel => 'Magenta';

  @override
  String get yellowLabel => 'Amarillo';

  @override
  String get blackLabel => 'Negro';

  @override
  String get lLabel => 'L';

  @override
  String get aLabel => 'A';

  @override
  String get bLabel => 'B';

  @override
  String get colorPickerHint =>
      'Usa el área de color y los deslizadores para seleccionar un color';

  @override
  String get colorSelected => 'Color seleccionado';

  @override
  String colorChanged(Object color) {
    return 'Color cambiado a $color';
  }

  @override
  String get invalidHex => 'Formato de color hexadecimal inválido';
}
