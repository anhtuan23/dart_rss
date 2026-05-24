import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

enum UpdatePeriod {
  hourly,
  daily,
  weekly,
  monthly,
  yearly,
}

class Syndication {
  final UpdatePeriod? updatePeriod;
  final int? updateFrequency;
  final DateTime? updateBase;

  const Syndication({
    this.updatePeriod,
    this.updateFrequency,
    this.updateBase,
  });

  factory Syndication.parse(XmlElement element) {
    return Syndication(
      updatePeriod: parseUpdatePeriod(
          findElementOrNull(element, 'sy:updatePeriod')?.innerText),
      updateFrequency:
          parseInt(findElementOrNull(element, 'sy:updateFrequency')?.innerText),
      updateBase:
          parseDateTime(findElementOrNull(element, 'sy:updateBase')?.innerText),
    );
  }
}

UpdatePeriod? parseUpdatePeriod(String? updatePeriodString) {
  switch (updatePeriodString) {
    case 'hourly':
      return UpdatePeriod.hourly;
    case 'daily':
      return UpdatePeriod.daily;
    case 'weekly':
      return UpdatePeriod.weekly;
    case 'monthly':
      return UpdatePeriod.monthly;
    case 'yearly':
      return UpdatePeriod.yearly;
    default:
      return null;
  }
}
