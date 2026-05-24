import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class AtomSource {
  final String? id;
  final String? title;
  final DateTime? updated;

  const AtomSource(this.id, this.title, this.updated);

  static AtomSource? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    final id = findElementOrNull(element, 'id')?.innerText;
    final title = findElementOrNull(element, 'title')?.innerText;
    final updated =
        parseDateTime(findElementOrNull(element, 'updated')?.innerText);
    return AtomSource(id, title, updated);
  }
}
