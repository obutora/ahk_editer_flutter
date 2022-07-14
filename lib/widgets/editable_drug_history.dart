import 'package:ahk_editor_flutter/entity/soap.dart';
import 'package:ahk_editor_flutter/provider/editing_history_provider.dart';
import 'package:ahk_editor_flutter/widgets/button/add_button.dart';
import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:ahk_editor_flutter/widgets/theme/input.dart';
import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditableDrugHistory extends HookConsumerWidget {
  const EditableDrugHistory({
    Key? key,
  }) : super(key: key);

  static const String id = 'editable_drug_history';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSoapCategory = useState<String>('S');
    final textControleller = TextEditingController(
      text: '',
    );

    final setHistory = ref.watch(editingHistoryProvider.notifier);

    final focusNode = FocusNode();

    void addSoap() {
      setHistory.addSoap(Soap(
        id: uuid.v4(),
        soap: selectedSoapCategory.value,
        body: textControleller.value.text,
      ));

      textControleller.clear();
    }

    return LimitedBox(
      maxWidth: MediaQuery.of(context).size.width / 1.6,
      child: Column(
        children: [
          FittedBox(
            child: Row(
              children: SoapLabels.map((e) => Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                            value: e,
                            activeColor: kPrimaryGreen,
                            groupValue: selectedSoapCategory.value,
                            onChanged: (e) {
                              selectedSoapCategory.value = e.toString();
                              focusNode.requestFocus();
                            }),
                        Text(
                          e,
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: kPrimaryGreen,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              letterSpacing: 1.4),
                        )
                      ],
                    ),
                  )).toList(),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                      focusNode: focusNode,
                      controller: textControleller,
                      decoration: StandardInputDecoration('SOAPを選んで入力してください'),
                      // maxLines: null,
                      style: inputText,
                      onSubmitted: (value) {
                        addSoap();
                      }),
                ),
                const SizedBox(width: 8),
                AddButton(
                  onPressed: () => addSoap(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
