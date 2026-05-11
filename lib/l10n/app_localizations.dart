import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Color Picker'**
  String get appTitle;

  /// No description provided for @colorPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Select a Color'**
  String get colorPickerTitle;

  /// No description provided for @rgbLabel.
  ///
  /// In en, this message translates to:
  /// **'RGB'**
  String get rgbLabel;

  /// No description provided for @hsvLabel.
  ///
  /// In en, this message translates to:
  /// **'HSV'**
  String get hsvLabel;

  /// No description provided for @hslLabel.
  ///
  /// In en, this message translates to:
  /// **'HSL'**
  String get hslLabel;

  /// No description provided for @cmykLabel.
  ///
  /// In en, this message translates to:
  /// **'CMYK'**
  String get cmykLabel;

  /// No description provided for @labLabel.
  ///
  /// In en, this message translates to:
  /// **'LAB'**
  String get labLabel;

  /// No description provided for @hexLabel.
  ///
  /// In en, this message translates to:
  /// **'Hex'**
  String get hexLabel;

  /// No description provided for @alphaLabel.
  ///
  /// In en, this message translates to:
  /// **'Alpha'**
  String get alphaLabel;

  /// No description provided for @redLabel.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get redLabel;

  /// No description provided for @greenLabel.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get greenLabel;

  /// No description provided for @blueLabel.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get blueLabel;

  /// No description provided for @hueLabel.
  ///
  /// In en, this message translates to:
  /// **'Hue'**
  String get hueLabel;

  /// No description provided for @saturationLabel.
  ///
  /// In en, this message translates to:
  /// **'Saturation'**
  String get saturationLabel;

  /// No description provided for @valueLabel.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get valueLabel;

  /// No description provided for @lightnessLabel.
  ///
  /// In en, this message translates to:
  /// **'Lightness'**
  String get lightnessLabel;

  /// No description provided for @cyanLabel.
  ///
  /// In en, this message translates to:
  /// **'Cyan'**
  String get cyanLabel;

  /// No description provided for @magentaLabel.
  ///
  /// In en, this message translates to:
  /// **'Magenta'**
  String get magentaLabel;

  /// No description provided for @yellowLabel.
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get yellowLabel;

  /// No description provided for @blackLabel.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get blackLabel;

  /// No description provided for @lLabel.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get lLabel;

  /// No description provided for @aLabel.
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get aLabel;

  /// No description provided for @bLabel.
  ///
  /// In en, this message translates to:
  /// **'B'**
  String get bLabel;

  /// No description provided for @colorPickerHint.
  ///
  /// In en, this message translates to:
  /// **'Use the color area and sliders to select a color'**
  String get colorPickerHint;

  /// No description provided for @colorSelected.
  ///
  /// In en, this message translates to:
  /// **'Color selected'**
  String get colorSelected;

  /// No description provided for @colorChanged.
  ///
  /// In en, this message translates to:
  /// **'Color changed to {color}'**
  String colorChanged(Object color);

  /// No description provided for @invalidHex.
  ///
  /// In en, this message translates to:
  /// **'Invalid hex color format'**
  String get invalidHex;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
