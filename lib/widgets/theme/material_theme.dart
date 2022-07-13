import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:flutter/material.dart';

class MaterialTheme extends StatelessWidget {
  const MaterialTheme({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: kPrimaryGreen,
        brightness: Brightness.light,
        visualDensity: VisualDensity.comfortable,
        fontFamily: 'UDEV',
      ),
      home: child,
    );
  }
}
