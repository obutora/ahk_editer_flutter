import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../entity/drug_history.dart';
import '../provider/search_history_provider.dart';
import '../widgets/button/rounded_button.dart';
import '../widgets/card/head_text_card.dart';
import '../widgets/card/mini_soap_card.dart';
import '../widgets/navigation/navi_rail.dart';
import '../widgets/theme/color.dart';
import '../widgets/theme/input.dart';
import '../widgets/theme/material_theme.dart';
import '../widgets/theme/text.dart';
import 'output_screen.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textControleller = TextEditingController();

    final searchWordNotifier = ref.watch(searchHistoryWordProvider.notifier);
    final historyList = ref.watch(searchHistoryProvider);

    return MaterialTheme(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const NaviRail(),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadTextCard(
                        title: '薬歴を検索',
                        description: '''SOAPの内容、グループ名で薬歴を検索できます'''),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextField(
                              // focusNode: focusNode,
                              autocorrect: false,
                              controller: textControleller,
                              decoration: StandardInputDecoration(
                                  searchWordNotifier.state),
                              // maxLines: null

                              style: inputText,
                              onSubmitted: (value) {}),
                        ),
                        const SizedBox(width: 8),
                        RoundedButton(
                            icon: CupertinoIcons.search,
                            onPressed: () {
                              searchWordNotifier.state = textControleller.text;
                            }),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '検索結果: ${historyList.length}件',
                      style: captionText1,
                    ),
                    const SizedBox(height: 8),
                    Column(
                      // spacing: 12,
                      // runSpacing: 8,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: historyList.map((DrugHistory history) {
                        return Container(
                          // width: 600,
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: kSecondaryGray.withOpacity(0.16)),
                            // color: kPrimaryGreen.withOpacity(0.16),
                          ),
                          child: Stack(
                            children: [
                              MiniSoapCard(history: history),
                              Positioned(
                                right: 0,
                                top: 8,
                                child: SoapCardPopupMenuButton(
                                  history: history,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
