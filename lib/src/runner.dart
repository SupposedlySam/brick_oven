import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:brick_oven/src/commands/cook_bricks.dart';
import 'package:brick_oven/src/commands/list.dart';
import 'package:brick_oven/src/commands/update.dart';
import 'package:brick_oven/src/version.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';

/// {@template brick_oven_runner}
/// Runs the brick_oven commands
/// {@endtemplate}
class BrickOvenRunner extends CommandRunner<int> {
  /// {@macro brick_oven_runner}
  BrickOvenRunner({
    required Logger logger,
    required PubUpdater pubUpdater,
  })  : _pubUpdater = pubUpdater,
        _logger = logger,
        super('brick_oven', 'Generate your bricks 🧱 with this oven 🎛') {
    argParser.addFlag(
      'version',
      negatable: false,
      help: 'Print the current version',
    );

    addCommand(CookBricksCommand(logger: logger));
    addCommand(ListCommand(logger: logger));
    addCommand(UpdateCommand(pubUpdater: pubUpdater, logger: logger));
  }

  /// the logger for the application
  final Logger _logger;
  final PubUpdater _pubUpdater;

  @override
  Future<int?> run(Iterable<String> args) async {
    try {
      return await runCommand(parse(args)) ?? ExitCode.success.code;
    } on FormatException catch (e) {
      _logger
        ..err(e.message)
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      _logger
        ..err(e.message)
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } catch (error) {
      _logger.err('$error');
      return ExitCode.software.code;
    }
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    int? exitCode = ExitCode.unavailable.code;

    if (topLevelResults['version'] == true) {
      _logger.alert('\nbrick_oven: $packageVersion\n');
      exitCode = ExitCode.success.code;
    } else {
      exitCode = await super.runCommand(topLevelResults);
    }

    if (topLevelResults.command?.name != 'update') {
      await _checkForUpdates();
    }

    return exitCode;
  }

  Future<void> _checkForUpdates() async {
    try {
      final latestVersion = await _pubUpdater.getLatestVersion(packageName);
      final isUpToDate = packageVersion == latestVersion;
      if (!isUpToDate) {
        _logger
          ..info('')
          ..info(
            '''
+------------------------------------------------------------------------------------+
|                                                                                    |
|                   ${lightYellow.wrap('Update available!')} ${lightCyan.wrap(packageVersion)} \u2192 ${lightCyan.wrap(latestVersion)}                      |
|  ${lightYellow.wrap('Changelog:')} ${lightCyan.wrap('https://github.com/mrgnhnt96/brick_oven/releases/tag/brick_oven-v$latestVersion')}  |
|                             Run ${cyan.wrap('brick_oven update')} to update                       |
|                                                                                    |
+------------------------------------------------------------------------------------+
''',
          );
      }
    } catch (_) {}
  }
}
