import 'package:ahk_editor_flutter/entity/soap.dart';
import 'package:ahk_editor_flutter/provider/editing_history_provider.dart';
import 'package:ahk_editor_flutter/widgets/button/add_button.dart';
import 'package:ahk_editor_flutter/widgets/theme/input.dart';
import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../card/soap_card.dart';

class EditableTrace extends HookConsumerWidget {
  const EditableTrace({
    Key? key,
  }) : super(key: key);

  static const String id = 'editable_drug_history';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSoapCategory = useState<String>('ト');
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
        // mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 12,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: textControleller,
                    decoration: StandardInputDecoration('トレースの文書を入力してください'),
                    maxLines: null,
                    style: inputText,
                    onSubmitted: (value) {}),
              ),
              const SizedBox(width: 8),
              AddButton(
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
