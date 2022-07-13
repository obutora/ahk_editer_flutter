import 'package:ahk_editor_flutter/entity/soap.dart';
import 'package:ahk_editor_flutter/provider/editing_history_provider.dart';
import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        soap: selectedSoapCategory.value,
        body: textControleller.value.text,
      ));

      textControleller.clear();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LimitedBox(
          maxWidth: MediaQuery.of(context).size.width / 1.6,
          child: Column(
            children: [
              FittedBox(
                child: Row(
                  children: SoapLabels.map((e) => Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: RawKeyboardListener(
                          focusNode: FocusNode(),
                          onKey: (event) async {
                            if (event.runtimeType == RawKeyDownEvent) {
                              print(
                                  'id: ${event.logicalKey.keyId}, label: ${event.logicalKey.keyLabel} debugName: ${event.logicalKey.debugName}');
                            }
                          },
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
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                        color: kPrimaryGreen,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        letterSpacing: 1.4),
                              )
                            ],
                          ),
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kPrimaryGreen, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kPrimaryGreen, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            focusColor: kPrimaryGreen,
                            labelText: 'SOAPを選んでから入力してください',
                          ),
                          // maxLines: null,
                          style: const TextStyle(
                              color: kSecondaryGray,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2),
                          onSubmitted: (value) {
                            print(value);
                            addSoap();
                          }

                          //   setHistory.addSoap(Soap(
                          //     soap: selectedSoapCategory.value,
                          //     body: value,
                          //   ));

                          //   textControleller.clear();
                          // },
                          ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: kPrimaryGreen,
                          onPrimary: Theme.of(context).colorScheme.onPrimary),
                      onPressed: () {
                        print(textControleller.value.text);

                        // setHistory.addSoap(Soap(
                        //   soap: selectedSoapCategory.value,
                        //   body: textControleller.value.text,
                        // ));
                        // textControleller.clear();
                        addSoap();
                      },
                      child: const Icon(
                        CupertinoIcons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
