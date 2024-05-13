import 'package:flutter_test/flutter_test.dart';
import 'package:test_node_flutter/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('PhysicsViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
