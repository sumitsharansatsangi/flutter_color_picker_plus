/// Common function lib
library;

import 'dart:math';
import 'package:flutter/painting.dart';
import 'colors.dart';

double getValueFromColor(Color color) {
  // Reference whites
  const Color coolWhite = Color.fromARGB(255, 204, 254, 255);
  const Color pureWhite = Color.fromARGB(255, 255, 255, 255);
  const Color warmWhite = Color.fromARGB(255, 255, 217, 128);

  // Convert normalized channel → 0–255
  int c(double v) => (v * 255).round().clamp(0, 255);

  // Extract channels
  final double r = c(color.r).toDouble();
  final double g = c(color.g).toDouble();
  final double b = c(color.b).toDouble();

  double distance(Color a) {
    final ar = c(a.r).toDouble();
    final ag = c(a.g).toDouble();
    final ab = c(a.b).toDouble();

    // Weighted distance (human vision favors green)
    return sqrt(
      0.30 * pow(r - ar, 2) + 0.59 * pow(g - ag, 2) + 0.11 * pow(b - ab, 2),
    );
  }

  final double dCool = distance(coolWhite);
  final double dPure = distance(pureWhite);
  final double dWarm = distance(warmWhite);

  // Cool → Pure
  if (dPure <= dWarm) {
    final double t = dCool / (dCool + dPure);
    return (t.clamp(0.0, 1.0)) * 0.5;
  }

  // Pure → Warm
  final double t = dPure / (dPure + dWarm);
  final double eased = sqrt(t.clamp(0.0, 1.0));
  return 0.5 + eased * 0.5;
}

/// Check if is good condition to use white foreground color by passing
/// the background color, and optional bias.
///
/// Reference:
///
/// Old: https://www.w3.org/TR/WCAG20-TECHS/G18.html
///
/// New: https://github.com/mchome/flutter_statusbarcolor/issues/40
bool useWhiteForeground(Color backgroundColor, {double bias = 0.0}) {
  // Perceived brightness using normalized RGB
  final double brightness =
      0.299 * backgroundColor.r +
      0.587 * backgroundColor.g +
      0.114 * backgroundColor.b;

  // Threshold tuned for UI contrast
  return brightness < 0.5 + bias;
}

/// Convert HSV to HSL
///
/// Reference: https://en.wikipedia.org/wiki/HSL_and_HSV#HSV_to_HSL
HSLColor hsvToHsl(HSVColor color) {
  double s = 0.0;
  double l = 0.0;
  l = (2 - color.saturation) * color.value / 2;
  if (l != 0) {
    if (l == 1) {
      s = 0.0;
    } else if (l < 0.5) {
      s = color.saturation * color.value / (l * 2);
    } else {
      s = color.saturation * color.value / (2 - l * 2);
    }
  }
  return HSLColor.fromAHSL(
    color.alpha,
    color.hue,
    s.clamp(0.0, 1.0),
    l.clamp(0.0, 1.0),
  );
}

/// Convert HSL to HSV
///
/// Reference: https://en.wikipedia.org/wiki/HSL_and_HSV#HSL_to_HSV
HSVColor hslToHsv(HSLColor color) {
  double s = 0.0;
  double v = 0.0;

  v =
      color.lightness +
      color.saturation *
          (color.lightness < 0.5 ? color.lightness : 1 - color.lightness);
  if (v != 0) s = 2 - 2 * color.lightness / v;

  return HSVColor.fromAHSV(
    color.alpha,
    color.hue,
    s.clamp(0.0, 1.0),
    v.clamp(0.0, 1.0),
  );
}

/// [RegExp] pattern for validation HEX color [String] inputs, allows only:
///
/// * exactly 1 to 8 digits in HEX format,
/// * only Latin A-F characters, case insensitive,
/// * and integer numbers 0,1,2,3,4,5,6,7,8,9,
/// * with optional hash (`#`) symbol at the beginning (not calculated in length).
///
/// ```dart
/// final RegExp hexInputValidator = RegExp(kValidHexPattern);
/// if (hexInputValidator.hasMatch(hex)) print('$hex might be a valid HEX color');
/// ```
/// Reference: https://en.wikipedia.org/wiki/Web_colors#Hex_triplet
const String kValidHexPattern = r'^#?[0-9a-fA-F]{1,8}';

/// [RegExp] pattern for validation complete HEX color [String], allows only:
///
/// * exactly 6 or 8 digits in HEX format,
/// * only Latin A-F characters, case insensitive,
/// * and integer numbers 0,1,2,3,4,5,6,7,8,9,
/// * with optional hash (`#`) symbol at the beginning (not calculated in length).
///
/// ```dart
/// final RegExp hexCompleteValidator = RegExp(kCompleteValidHexPattern);
/// if (hexCompleteValidator.hasMatch(hex)) print('$hex is valid HEX color');
/// ```
/// Reference: https://en.wikipedia.org/wiki/Web_colors#Hex_triplet
const String kCompleteValidHexPattern =
    r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$';

/// Try to convert text input or any [String] to valid [Color].
/// The [String] must be provided in one of those formats:
///
/// * RGB
/// * #RGB
/// * RRGGBB
/// * #RRGGBB
/// * AARRGGBB
/// * #AARRGGBB
///
/// Where: A stands for Alpha, R for Red, G for Green, and B for blue color.
/// It will only accept 3/6/8 long HEXs with an optional hash (`#`) at the beginning.
/// Allowed characters are Latin A-F case insensitive and numbers 0-9.
/// Optional [enableAlpha] can be provided (it's `true` by default). If it's set
/// to `false` transparency information (alpha channel) will be removed.
/// ```dart
/// /// // Valid 3 digit HEXs:
/// colorFromHex('abc') == Color(0xffaabbcc)
/// colorFromHex('ABc') == Color(0xffaabbcc)
/// colorFromHex('ABC') == Color(0xffaabbcc)
/// colorFromHex('#Abc') == Color(0xffaabbcc)
/// colorFromHex('#abc') == Color(0xffaabbcc)
/// colorFromHex('#ABC') == Color(0xffaabbcc)
/// // Valid 6 digit HEXs:
/// colorFromHex('aabbcc') == Color(0xffaabbcc)
/// colorFromHex('AABbcc') == Color(0xffaabbcc)
/// colorFromHex('AABBCC') == Color(0xffaabbcc)
/// colorFromHex('#AABbcc') == Color(0xffaabbcc)
/// colorFromHex('#aabbcc') == Color(0xffaabbcc)
/// colorFromHex('#AABBCC') == Color(0xffaabbcc)
/// // Valid 8 digit HEXs:
/// colorFromHex('ffaabbcc') == Color(0xffaabbcc)
/// colorFromHex('ffAABbcc') == Color(0xffaabbcc)
/// colorFromHex('ffAABBCC') == Color(0xffaabbcc)
/// colorFromHex('ffaabbcc', enableAlpha: true) == Color(0xffaabbcc)
/// colorFromHex('FFAAbbcc', enableAlpha: true) == Color(0xffaabbcc)
/// colorFromHex('ffAABBCC', enableAlpha: true) == Color(0xffaabbcc)
/// colorFromHex('FFaabbcc', enableAlpha: true) == Color(0xffaabbcc)
/// colorFromHex('#ffaabbcc') == Color(0xffaabbcc)
/// colorFromHex('#ffAABbcc') == Color(0xffaabbcc)
/// colorFromHex('#FFAABBCC') == Color(0xffaabbcc)
/// colorFromHex('#ffaabbcc', enableAlpha: true) == Color(0xffaabbcc)
/// colorFromHex('#FFAAbbcc', enableAlpha: true) == Color(0xffaabbcc)
/// colorFromHex('#ffAABBCC', enableAlpha: true) == Color(0xffaabbcc)
/// colorFromHex('#FFaabbcc', enableAlpha: true) == Color(0xffaabbcc)
/// // Invalid HEXs:
/// colorFromHex('bc') == null // length 2
/// colorFromHex('aabbc') == null // length 5
/// colorFromHex('#ffaabbccd') == null // length 9 (+#)
/// colorFromHex('aabbcx') == null // x character
/// colorFromHex('#aabbвв') == null // в non-latin character
/// colorFromHex('') == null // empty
/// ```
/// Reference: https://en.wikipedia.org/wiki/Web_colors#Hex_triplet
Color? colorFromHex(String inputString, {bool enableAlpha = true}) {
  // Registers validator for exactly 6 or 8 digits long HEX (with optional #).
  final RegExp hexValidator = RegExp(kCompleteValidHexPattern);
  // Validating input, if it does not match — it's not proper HEX.
  if (!hexValidator.hasMatch(inputString)) return null;
  // Remove optional hash if exists and convert HEX to UPPER CASE.
  String hexToParse = inputString.replaceFirst('#', '').toUpperCase();
  // It may allow HEXs with transparency information even if alpha is disabled,
  if (!enableAlpha && hexToParse.length == 8) {
    // but it will replace this info with 100% non-transparent value (FF).
    hexToParse = 'FF${hexToParse.substring(2)}';
  }
  // HEX may be provided in 3-digits format, let's just duplicate each letter.
  if (hexToParse.length == 3) {
    hexToParse = hexToParse.split('').expand((i) => [i * 2]).join();
  }
  // We will need 8 digits to parse the color, let's add missing digits.
  if (hexToParse.length == 6) hexToParse = 'FF$hexToParse';
  // HEX must be valid now, but as a precaution, it will just "try" to parse it.
  final intColorValue = int.tryParse(hexToParse, radix: 16);
  // If for some reason HEX is not valid — abort the operation, return nothing.
  if (intColorValue == null) return null;
  // Register output color for the last step.
  final color = Color(intColorValue);
  // Decide to return color with transparency information or not.
  return enableAlpha ? color : color.withAlpha(255);
}

/// Converts `dart:ui` [Color] to the 6/8 digits HEX [String].
///
/// Prefixes a hash (`#`) sign if [includeHashSign] is set to `true`.
/// The result will be provided as UPPER CASE, it can be changed via [toUpperCase]
/// flag set to `false` (default is `true`). Hex can be returned without alpha
/// channel information (transparency), with the [enableAlpha] flag set to `false`.
String colorToHex(
  Color color, {
  bool includeHashSign = false,
  bool enableAlpha = true,
  bool toUpperCase = true,
}) {
  int c(double v) => (v * 255).round().clamp(0, 255);

  final String hex =
      (includeHashSign ? '#' : '') +
      (enableAlpha ? c(color.a).toRadixString(16).padLeft(2, '0') : '') +
      c(color.r).toRadixString(16).padLeft(2, '0') +
      c(color.g).toRadixString(16).padLeft(2, '0') +
      c(color.b).toRadixString(16).padLeft(2, '0');

  return toUpperCase ? hex.toUpperCase() : hex;
}

// Shorthand for padLeft of RadixString, DRY.
String padRadix(int value) => value.toRadixString(16).padLeft(2, '0');

// Extension for String
extension ColorExtension1 on String {
  Color? toColor() {
    Color? color = colorFromName(this);
    if (color != null) return color;
    return colorFromHex(this);
  }
}

// Extension from Color
extension ColorExtension2 on Color {
  String toHexString({
    bool includeHashSign = false,
    bool enableAlpha = true,
    bool toUpperCase = true,
  }) => colorToHex(
    this,
    includeHashSign: false,
    enableAlpha: true,
    toUpperCase: true,
  );
}

/// Convert RGB to CMYK
List<double> rgbToCmyk(Color color) {
  final double r = color.r;
  final double g = color.g;
  final double b = color.b;

  final double k = 1 - max(r, max(g, b));
  if (k == 1) return [0, 0, 0, 1];

  final double c = (1 - r - k) / (1 - k);
  final double m = (1 - g - k) / (1 - k);
  final double y = (1 - b - k) / (1 - k);

  return [c, m, y, k];
}

/// Convert CMYK to RGB
Color cmykToRgb(double c, double m, double y, double k) {
  final double r = (1 - c) * (1 - k);
  final double g = (1 - m) * (1 - k);
  final double b = (1 - y) * (1 - k);

  return Color.fromRGBO(
    (r * 255).round(),
    (g * 255).round(),
    (b * 255).round(),
    1.0,
  );
}

/// Convert RGB to LAB
List<double> rgbToLab(Color color) {
  // Convert to XYZ first
  double r = color.r;
  double g = color.g;
  double b = color.b;

  // Linearize RGB
  r = r > 0.04045 ? pow((r + 0.055) / 1.055, 2.4).toDouble() : r / 12.92;
  g = g > 0.04045 ? pow((g + 0.055) / 1.055, 2.4).toDouble() : g / 12.92;
  b = b > 0.04045 ? pow((b + 0.055) / 1.055, 2.4).toDouble() : b / 12.92;

  r *= 100;
  g *= 100;
  b *= 100;

  // XYZ
  final double x = r * 0.4124 + g * 0.3576 + b * 0.1805;
  final double y = r * 0.2126 + g * 0.7152 + b * 0.0722;
  final double z = r * 0.0193 + g * 0.1192 + b * 0.9505;

  // LAB
  final double xr = x / 95.047;
  final double yr = y / 100.0;
  final double zr = z / 108.883;

  final double fx = xr > 0.008856 ? pow(xr, 1/3).toDouble() : (7.787 * xr) + 16/116;
  final double fy = yr > 0.008856 ? pow(yr, 1/3).toDouble() : (7.787 * yr) + 16/116;
  final double fz = zr > 0.008856 ? pow(zr, 1/3).toDouble() : (7.787 * zr) + 16/116;

  final double l = (116 * fy) - 16;
  final double a = 500 * (fx - fy);
  final double bb = 200 * (fy - fz);

  return [l, a, bb];
}

/// Convert LAB to RGB (simplified approximation)
Color labToRgb(double l, double a, double b) {
  double y = (l + 16) / 116;
  double x = a / 500 + y;
  double z = y - b / 200;

  x = x > 0.206897 ? pow(x, 3).toDouble() : (x - 16/116) / 7.787;
  y = y > 0.206897 ? pow(y, 3).toDouble() : (y - 16/116) / 7.787;
  z = z > 0.206897 ? pow(z, 3).toDouble() : (z - 16/116) / 7.787;

  x *= 95.047;
  y *= 100.0;
  z *= 108.883;

  x /= 100;
  y /= 100;
  z /= 100;

  double r = x * 3.2406 + y * -1.5372 + z * -0.4986;
  double g = x * -0.9689 + y * 1.8758 + z * 0.0415;
  double bb = x * 0.0557 + y * -0.2040 + z * 1.0570;

  r = r > 0.0031308 ? 1.055 * pow(r, 1/2.4) - 0.055 : 12.92 * r;
  g = g > 0.0031308 ? 1.055 * pow(g, 1/2.4) - 0.055 : 12.92 * g;
  bb = bb > 0.0031308 ? 1.055 * pow(bb, 1/2.4) - 0.055 : 12.92 * bb;

  return Color.fromRGBO(
    (r.clamp(0, 1) * 255).round(),
    (g.clamp(0, 1) * 255).round(),
    (bb.clamp(0, 1) * 255).round(),
    1.0,
  );
}
