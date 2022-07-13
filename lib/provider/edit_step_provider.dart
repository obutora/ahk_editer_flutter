import 'package:hooks_riverpod/hooks_riverpod.dart';

final editStepProvider = StateNotifierProvider<EditStepNotifier, int>((ref) {
  return EditStepNotifier();
});

class EditStepNotifier extends StateNotifier<int> {
  EditStepNotifier() : super(0);

  void change(int index) {
    state = index;
  }

  void clear() {
    state = 0;
  }

  void next() {
    state++;
  }

  void back() {
    state--;
  }
}
