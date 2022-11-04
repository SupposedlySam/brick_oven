import 'package:test/test.dart';

import 'package:brick_oven/domain/brick_oven_yaml.dart';
import 'package:brick_oven/src/exception.dart';

void main() {
  test('$BrickOvenException can be instanciated', () {
    expect(() => const BrickOvenException('test'), returnsNormally);
  });

  group('$BrickOvenNotFoundException', () {
    test('can be instanciated', () {
      expect(const BrickOvenNotFoundException(), isA<BrickOvenException>());

      expect(() => const BrickOvenNotFoundException(), returnsNormally);
    });

    test('has the correct message', () {
      expect(
        const BrickOvenNotFoundException().message,
        'Cannot find ${BrickOvenYaml.file}.'
        '\nCreate the file and try again.',
      );
    });
  });

  group('$BrickNotFoundException', () {
    test('can be instanciated', () {
      expect(const BrickNotFoundException('brick'), isA<BrickOvenException>());

      expect(() => const BrickNotFoundException('brick'), returnsNormally);
    });

    test('has the correct message', () {
      const brick = 'test';
      expect(
        const BrickNotFoundException(brick).message,
        'Cannot find $brick.\n'
        'Make sure to provide a valid brick name '
        'from the ${BrickOvenYaml.file}.',
      );
    });
  });

  group('$UnknownKeysException', () {
    test('can be instanciated', () {
      expect(UnknownKeysException(['test'], 'loc'), isA<BrickOvenException>());

      expect(() => UnknownKeysException(['test'], 'loc'), returnsNormally);
    });

    test('has the correct message', () {
      const keys = ['test', 'test2'];
      const location = 'location';
      expect(
        UnknownKeysException(keys, location).message,
        'Unknown keys: ${keys.join(', ')}, in $location',
      );
    });
  });

  group('$VariableException', () {
    test('can be instanciated', () {
      expect(
        const VariableException(variable: 'test', reason: 'test'),
        isA<BrickOvenException>(),
      );

      expect(
        () => const VariableException(variable: 'test', reason: 'test'),
        returnsNormally,
      );
    });

    test('has the correct message', () {
      const variable = '💩';
      const reason = '🚽';

      expect(
        const VariableException(variable: variable, reason: reason).message,
        'Variable "$variable" is invalid -- $reason',
      );
    });
  });

  group('$DirectoryException', () {
    test('can be instanciated', () {
      expect(
        const DirectoryException(directory: 'test', reason: 'test'),
        isA<BrickOvenException>(),
      );

      expect(
        () => const DirectoryException(directory: 'test', reason: 'test'),
        returnsNormally,
      );
    });

    test('has the correct message', () {
      const directory = '💩';
      const reason = '🚽';

      expect(
        const DirectoryException(directory: directory, reason: reason).message,
        'Invalid directory config: "$directory"\nReason: $reason',
      );
    });
  });

  group('$SourceException', () {
    test('can be instanciated', () {
      expect(
        const SourceException(source: 'test', reason: 'test'),
        isA<BrickOvenException>(),
      );

      expect(
        () => const SourceException(source: 'test', reason: 'test'),
        returnsNormally,
      );
    });

    test('has the correct message', () {
      const source = '💩';
      const reason = '🚽';

      expect(
        const SourceException(source: source, reason: reason).message,
        'Invalid source config: "$source"\nReason: $reason',
      );
    });
  });

  group('$BrickException', () {
    test('can be instanciated', () {
      expect(
        const BrickException(brick: 'test', reason: 'test'),
        isA<BrickOvenException>(),
      );

      expect(
        () => const BrickException(brick: 'test', reason: 'test'),
        returnsNormally,
      );
    });

    test('has the correct message', () {
      const brick = '💩';
      const reason = '🚽';

      expect(
        const BrickException(brick: brick, reason: reason).message,
        'Invalid brick config: "$brick"\nReason: $reason',
      );
    });
  });

  group('$FileException', () {
    test('can be instanciated', () {
      expect(
        const FileException(file: 'test', reason: 'test'),
        isA<BrickOvenException>(),
      );

      expect(
        () => const FileException(file: 'test', reason: 'test'),
        returnsNormally,
      );
    });

    test('has the correct message', () {
      const file = '💩';
      const reason = '🚽';

      expect(
        const FileException(file: file, reason: reason).message,
        'Invalid file config: "$file"\nReason: $reason',
      );
    });
  });
}
