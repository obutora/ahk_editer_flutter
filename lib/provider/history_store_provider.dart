import 'package:ahk_editor_flutter/entity/drug_history.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final historyStoreProvider =
    StateNotifierProvider<HistoryStoreNotifier, List<DrugHistory>>((ref) {
  return HistoryStoreNotifier();
});

class HistoryStoreNotifier extends StateNotifier<List<DrugHistory>> {
  HistoryStoreNotifier() : super([]);

  void init(List<DrugHistory> value) async {
    state = value;

    // print(state.length);
    // print(state.map((e) => e.soapList).toList());
  }

  void add(DrugHistory history) {
    state = [...state, history];
  }

  void remove(DrugHistory history) {
    state = state.where((e) => e.id != history.id).toList();
  }
}
