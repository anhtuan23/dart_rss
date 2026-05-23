# Dart RSS Context

Last researched: 2026-05-23.

## Role

This package parses RSS 1.0, RSS 2.0, and Atom feeds, including common modules
such as Dublin Core, Media RSS, iTunes, and Podcast Index. Readdict uses it as
part of RSS source fetching and item parsing.

## Package Shape

- Package name: `dart_rss`.
- Current version: `2.0.1`.
- Dart SDK constraint: `>=2.12.0-259.9.beta <3.0.0`.
- Lints: `pedantic`.
- Public library: `lib/dart_rss.dart`.
- Main implementation folders:
  - `lib/domain/`: feed, item, category, enclosure, Atom, RSS 1, RSS 2, and
    module models.
  - `lib/domain/dublin_core/`, `lib/domain/media/`,
    `lib/domain/podcast_index/`: module-specific models.
  - `lib/util/`: parser helpers.

## Public API Notes

- The package exports many domain model classes directly from
  `lib/dart_rss.dart`.
- `lib/domain/dart_rss.dart` adds a higher-level `WebFeed` wrapper that can
  detect feed version, parse XML strings, normalize RSS/Atom data, and fetch a
  feed from a URL through `http`.
- `SafeParseDateTime.safeParse` contains custom date fallback behavior. Treat
  date parsing changes as behavior changes and cover them with tests.

## Tests And Fixtures

- Tests live under `test/`.
- XML fixtures live under `test/xml/`.
- Coverage includes Atom, RSS 1.0, RSS 2.0, invalid XML, media modules, Dublin
  Core, iTunes, Podcast Index, and date parsing.

## Validation

Run from `dart_rss/`:

- `dart pub get`
- `dart format .`
- `dart analyze`
- `dart test`
