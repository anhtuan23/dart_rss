import 'dart:core';

import 'package:intl/intl.dart';
import 'package:xml/xml.dart';

XmlElement? findElementOrNull(XmlElement element, String name,
    {String? namespace}) {
  try {
    return element.findAllElements(name, namespace: namespace).first;
  } on StateError {
    return null;
  }
}

List<XmlElement>? findAllDirectElementsOrNull(XmlElement element, String name,
    {String? namespace}) {
  try {
    return element.findElements(name, namespace: namespace).toList();
  } on StateError {
    return null;
  }
}

bool? parseBoolLiteral(XmlElement element, String tagName) {
  final v = findElementOrNull(element, tagName)?.innerText.toLowerCase().trim();
  if (v == null) return null;
  return ['yes', 'true'].contains(v);
}

DateTime? parseDateTime(String? dateTimeString) {
  if (dateTimeString == null) return null;
  try {
    return DateTime.parse(dateTimeString);
  } on FormatException {
    return _parseRfc822DateTime(dateTimeString);
  }
}

DateTime? _parseRfc822DateTime(String dateTimeString) {
  final parts = dateTimeString.split(RegExp(r'\s+'));
  if (parts.length == 4) {
    try {
      return DateFormat('EEE, d MMM yyyy', 'en_US').parse(dateTimeString);
    } on FormatException {
      return null;
    }
  }
  if (parts.length < 6) {
    return null;
  }
  try {
    final dateTimePart = parts.sublist(0, 5).join(' ');
    final parsedDateTime = DateFormat('EEE, d MMM yyyy HH:mm:ss', 'en_US')
        .parse(dateTimePart, true);
    final offset = _parseTimeZoneOffset(parts[5]);
    if (offset == null) {
      return null;
    }
    return parsedDateTime.subtract(offset).toUtc();
  } on FormatException {
    return null;
  }
}

Duration? _parseTimeZoneOffset(String timeZone) {
  const abbreviationOffsets = {
    'UT': Duration.zero,
    'UTC': Duration.zero,
    'GMT': Duration.zero,
    'EST': Duration(hours: -5),
    'EDT': Duration(hours: -4),
    'CST': Duration(hours: -6),
    'CDT': Duration(hours: -5),
    'MST': Duration(hours: -7),
    'MDT': Duration(hours: -6),
    'PST': Duration(hours: -8),
    'PDT': Duration(hours: -7),
  };
  final abbreviationOffset = abbreviationOffsets[timeZone.toUpperCase()];
  if (abbreviationOffset != null) {
    return abbreviationOffset;
  }
  final offsetMatch = RegExp(r'^([+-])(\d{2})(\d{2})$').firstMatch(timeZone);
  if (offsetMatch == null) {
    return null;
  }
  final sign = offsetMatch.group(1) == '-' ? -1 : 1;
  final hours = int.parse(offsetMatch.group(2)!);
  final minutes = int.parse(offsetMatch.group(3)!);
  return Duration(hours: sign * hours, minutes: sign * minutes);
}

int? parseInt(String? intString) {
  if (intString == null) return null;
  return int.tryParse(intString);
}
