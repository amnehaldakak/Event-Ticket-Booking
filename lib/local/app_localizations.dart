import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'select_ticket': 'Select Ticket Type',
      'continue': 'Continue',
      'booking': 'Booking',
      'review_confirm': 'Review & Confirm',
      'full_name': 'Full Name',
      'email': 'Email',
      'phone': 'Phone Number',
      'country': 'Country',
      'job': 'Job Title (optional)',
      'org': 'Organization/Company (optional)',
      'promo': 'Promo Code',
      'review_booking': 'Review Booking',
      'confirm_booking': 'Confirm Booking',
      'booking_confirmed': 'Booking Confirmed!',
      'reference': 'Reference',
      'back_home': 'Back to Home',
      'please_review': 'Please review your booking:',
      'total': 'Total',
      'ticket_general': 'General',
      'ticket_student': 'Student',
      'ticket_vip': 'VIP',
      'ticket_group': 'Group',
      'desc_general': 'Standard entry ticket.',
      'desc_student': 'Discounted ticket for students.',
      'desc_vip': 'VIP access with perks.',
      'desc_group': 'Group ticket for 5 people.',
      'price': 'Price',
      'required': 'Required',
      'invalid_email': 'Invalid email',
      'too_short': 'Too short',
    },
    'de': {
      'select_ticket': 'Tickettyp auswählen',
      'continue': 'Weiter',
      'booking': 'Buchung',
      'review_confirm': 'Überprüfen & Bestätigen',
      'full_name': 'Vollständiger Name',
      'email': 'E-Mail',
      'phone': 'Telefonnummer',
      'country': 'Land',
      'job': 'Berufsbezeichnung (optional)',
      'org': 'Organisation/Firma (optional)',
      'promo': 'Aktionscode',
      'review_booking': 'Buchung überprüfen',
      'confirm_booking': 'Buchung bestätigen',
      'booking_confirmed': 'Buchung bestätigt!',
      'reference': 'Referenz',
      'back_home': 'Zurück zur Startseite',
      'please_review': 'Bitte überprüfen Sie Ihre Buchung:',
      'total': 'Gesamt',
      'ticket_general': 'Standard',
      'ticket_student': 'Student',
      'ticket_vip': 'VIP',
      'ticket_group': 'Gruppe',
      'desc_general': 'Standard-Eintrittskarte.',
      'desc_student': 'Ermäßigtes Ticket für Studenten.',
      'desc_vip': 'VIP-Zugang mit Vorteilen.',
      'desc_group': 'Gruppenticket für 5 Personen.',
      'price': 'Preis',
      'required': 'Erforderlich',
      'invalid_email': 'Ungültige E-Mail',
      'too_short': 'Zu kurz',
    },
  };

  String get(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']![key]!;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
