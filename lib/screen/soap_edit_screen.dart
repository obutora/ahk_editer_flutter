import 'package:ahk_editor_flutter/widgets/card/head_text_card.dart';
import 'package:ahk_editor_flutter/widgets/navigation/navi_rail.dart';
import 'package:ahk_editor_flutter/widgets/theme/material_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/card/soap_card.dart';
import '../widgets/editable_drug_history.dart';

class SoapEditScreen extends StatelessWidget {
  const SoapEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialTheme(
      child: Scaffold(
        backgroundColor: Colors.white,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: kPrimaryGreen,
        //   child: Row(
        //     children: const [
        //       Icon(
        //         CupertinoIcons.return_icon,
        //         color: Colors.white,
        //       ),
        //       Text('data')
        //     ],
        //   ),
        //   onPressed: () {},
        // ),
        body: Row(
          children: [
            const NaviRail(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadTextCard(),
                  const EditableDrugHistory(),
                  const SizedBox(height: 20),
                  const SoapCard(),
                  const SizedBox(
                    height: 12,
                  ),
                  LimitedBox(
                    maxWidth: MediaQuery.of(context).size.width / 1.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.right_chevron),
                          label: const Text('決定して次に進む'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
