import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../entity/soap.dart';
import '../../../provider/editing_history_provider.dart';
import '../../button/rounded_button.dart';
import '../../card/soap_card.dart';
import '../../theme/color.dart';
import '../../theme/input.dart';
import '../../theme/text.dart';

class EditableDrugHistory extends HookConsumerWidget {
  const EditableDrugHistory({
    Key? key,
  }) : super(key: key);

  static const String id = 'editable_drug_history';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSoapCategory = useState<String>('#');
    final textControleller = TextEditingController(
      text: '',
    );

    final setHistory = ref.watch(editingHistoryProvider.notifier);

    // final focusNode = FocusNode();

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
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                              // focusNode.requestFocus();
                            }),
                        Text(
                          e,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
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
          Row(
            children: [
              Flexible(
                child: TextField(
                    // focusNode: focusNode,
                    autocorrect: false,
                    controller: textControleller,
                    decoration: StandardInputDecoration('SOAPを選んで入力してください'),
                    // maxLines: null,
                    style: inputText,
                    onSubmitted: (value) {
                      addSoap();
                    }),
              ),
              const SizedBox(width: 8),
              RoundedButton(
                onPressed: () => addSoap(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SoapCard(),
        ],
      ),
    );
  }
}
