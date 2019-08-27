flutter pub pub run intl_translation:extract_to_arb --output-dir=res/ lib/l10n/localization_intl.dart
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/localization_intl.dart res/intl_en_US.arb res/intl_vi_VN.arb
