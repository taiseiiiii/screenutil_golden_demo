import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      // Currently, goldens are not generated/validated in CI for this repo. We have settled on the goldens for this package
      // being captured/validated by developers running on MacOSX. We may revisit this in the future if there is a reason to invest
      // in more sophistication
      skipGoldenAssertion: () => !Platform.isMacOS,
      enableRealShadows: true,
    ),
  );
}

class _Wrapper extends StatelessWidget {
  const _Wrapper(this.child);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(1400, 926),);
    return child;
  }
}

Widget pageWrapper(Widget widget) => 
  MediaQuery(
    data: const MediaQueryData(), 
    child: MaterialApp(
      home: Scaffold(body: _Wrapper(widget)),
      debugShowCheckedModeBanner: false,
    ),
  );

class TestDevice {
  static const all = [
    Device(
      size: Size(375, 667), 
      name: 'iPhoneSE',
      devicePixelRatio: 3,
    ),
    Device(
      size: Size(375, 812), 
      name: 'iPhone13Mini',
      devicePixelRatio: 3,
    ),
    Device(
      size: Size(428, 926), 
      name: 'iPhone13ProMax',
      devicePixelRatio: 3,
    ),
  ];
}
