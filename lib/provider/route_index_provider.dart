import 'package:hooks_riverpod/hooks_riverpod.dart';

final routeIndexProvider =
    StateNotifierProvider<RouteIndexNotifier, int>((ref) {
  return RouteIndexNotifier();
});

class RouteIndexNotifier extends StateNotifier<int> {
  RouteIndexNotifier() : super(1);

  void change(int index) {
    state = index;
  }
}
