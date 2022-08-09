import 'package:ahk_editor_flutter/entity/soap.dart';
import 'package:ahk_editor_flutter/provider/editing_history_provider.dart';
import 'package:ahk_editor_flutter/widgets/dialog/check_remove_soap_dialog.dart';
import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SoapCard extends HookConsumerWidget {
  const SoapCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(editingHistoryProvider);

    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: history.soapList.length,
        itemBuilder: (context, index) {
          final soap = history.soapList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: kSecondaryGray.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: SoapLine(soap: soap),
          );
          // return ListTile(
          //   title: Text(history.soapList[index].soap),
          //   subtitle: Text(history.soapList[index].body),

          // );
        });
  }
}

class SoapLine extends HookConsumerWidget {
  const SoapLine({
    Key? key,
    required this.soap,
  }) : super(key: key);

  final Soap soap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = useState(false);
    final controller = TextEditingController(text: soap.body);
    // final history = ref.watch(editingHistoryProvider);
    final setHistory = ref.watch(editingHistoryProvider.notifier);

    return Row(
      children: [
        CircleAvatar(
          backgroundColor: soap.soap != 'ト' ? kPrimaryGreen : kInfoBlue,
          child: Text(soap.soap,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white)),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: isEditing.value
              ? Focus(
                  onFocusChange: (hasFocus) {
                    setHistory.updateSoap(soap, controller.text);
                  },
                  child: TextField(
                    controller: controller,
                    style: bodyText2,
                  ),
                )
              : SelectableText(
                  soap.body,
                  style: bodyText1,
                  showCursor: true,
                ),
        ),
        IconButton(
            icon: const Icon(CupertinoIcons.pen, color: kPrimaryGreen),
            onPressed: () {
              isEditing.value = !isEditing.value;
            }),
        IconButton(
            onPressed: () {
              checkRemoveSoapLineDialog(context, ref, soap);
              // setHistory.removeSoap(soap.id);
            },
            icon: const Icon(
              CupertinoIcons.trash,
              color: kAlertRed,
            ))
      ],
    );
  }
}
