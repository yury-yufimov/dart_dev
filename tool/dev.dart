// Copyright 2015 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library dart_dev.dev;

import 'package:dart_dev/dart_dev.dart';

main(args) async {
  var directories = ['bin/', 'lib/', 'test/', 'tool/'];
  config.analyze.entryPoints = directories;
  config.copyLicense.directories = directories;
  config.coverage.reportOn = ['bin/', 'lib/'];
  config.format
    ..paths = directories
    ..exclude = [
      'test/integration/generated_runner.dart',
      'test/unit/browser/generated_runner.dart',
      'test/unit/vm/generated_runner.dart',
    ];
  config.genTestRunner.configs = [
    new TestRunnerConfig(
        directory: 'test/unit/browser', env: Environment.browser),
    new TestRunnerConfig(directory: 'test/unit/vm', env: Environment.vm),
    new TestRunnerConfig(directory: 'test/integration', env: Environment.vm),
  ];
  config.test
    ..concurrency = 1
    ..platforms = ['content-shell', 'vm']
    ..integrationTests = ['test/integration/generated_runner.dart']
    ..unitTests = [
      'test/unit/browser/generated_runner.dart',
      'test/unit/vm/generated_runner.dart',
    ];

  await dev(args);
}
