import 'package:ahk_editor_flutter/controller/api_handler.dart';
import 'package:ahk_editor_flutter/widgets/card/head_text_card.dart';
import 'package:ahk_editor_flutter/widgets/theme/material_theme.dart';
import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/history_store_provider.dart';
import '../widgets/navigation/navi_rail.dart';
import '../widgets/theme/color.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeState = ref.watch(historyStoreProvider.notifier);
    return MaterialTheme(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const NaviRail(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
              child: ListView(
                children: const [
                  HeadTextCard(
                      title: 'AHK Editor in flutter',
                      description:
                          'このアプリはAHKを非エンジニアの方でもカンタンに利用できるようにするためのアプリです。'),
                  SizedBox(height: 24),
                  DescCard(
                    icon: CupertinoIcons.home,
                    text: '← のアイコンから設定ファイルを読み込みましょう',
                  ),
                  SizedBox(height: 12),
                  DescCard(
                    icon: CupertinoIcons.pen,
                    text: '← のアイコンからSOAPを入力して保存できます',
                  ),
                  SizedBox(height: 12),
                  DescCard(
                    icon: CupertinoIcons.tray_arrow_up_fill,
                    text: '← のアイコンから実行用のファイルを作成することができます',
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  // Text('Produced by Kunihiko Haga.', style: captionText1),
                  CopyRightText(),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class CopyRightText extends HookWidget {
  const CopyRightText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textState = useState('© 2022 Kunihiko Haga.');

    return Row(
      children: [
        const Spacer(),
        GestureDetector(
          onTap: () async {
            print('start test');
            final test = await ApiHandler.testHistory();
            textState.value = test;
          },
          child: Text(textState.value,
              style: captionText1.copyWith(color: kPrimaryGreen)),
        ),
      ],
    );
  }
}

class DescCard extends StatelessWidget {
  const DescCard({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: kPrimaryGreen.withOpacity(0.32)),
      ),
      leading: Icon(
        icon,
        color: kPrimaryGreen,
      ),
      title: Text(
        text,
        style: bodyText2.copyWith(
          color: kSecondaryGray,
        ),
      ),
    );
  }
}
