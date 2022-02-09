import 'package:brick_oven/enums/mustache_format.dart';
import 'package:test/test.dart';

void main() {
  group('MustacheFormatX', () {
    group('#toMustache', () {
      test('formats the content correctly', () {
        const format = MustacheFormat.camelCase;
        const content = 'sup_dude';

        expect(
          format.toMustache(content),
          '{{#camelCase}}$content{{/camelCase}}',
        );
      });

      test('uses invert when provided', () {
        const format = MustacheFormat.camelCase;
        const content = 'sup_dude';

        expect(
          format.toMustache(content, invert: true),
          '{{^camelCase}}$content{{/camelCase}}',
        );
      });
    });
  });

  group('ListX', () {
    group('#retrieve', () {
      test('enum returns the value when provided', () {
        final result = MustacheFormat.values.retrieve('camelCase');

        expect(result, MustacheFormat.camelCase);
      });

      test('string returns the value when provided', () {
        const search = 'num';
        final result = ['val', search].retrieve(search);

        expect(result, search);
      });

      test('int returns the value when provided', () {
        const search = 1;
        final result = [2, search].retrieve(search);

        expect(result, search);
      });

      test('returns null when not provided', () {
        final result = MustacheFormat.values.retrieve('not_a_format');

        expect(result, isNull);
      });
    });
  });
}
