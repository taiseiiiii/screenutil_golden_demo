import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:screenutil_golden_demo/main.dart';

import 'flutter_test_config.dart';

void main() {
  testGoldens('MyHomePage', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: TestDevice.all)
      ..addScenario(
        widget: pageWrapper(const MyHomePage(title:'screenutil_golden_demo')),
        name: 'default',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'MyHomePage');
  });
}
