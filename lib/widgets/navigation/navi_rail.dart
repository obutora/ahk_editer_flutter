import 'package:ahk_editor_flutter/provider/route_index_provider.dart';
import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:ahk_editor_flutter/widgets/theme/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NaviRail extends ConsumerWidget {
  const NaviRail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(routeIndexProvider);
    final setNav = ref.watch(routeIndexProvider.notifier);

    return NavigationRail(
        indicatorColor: kPrimaryGreen.withOpacity(0.16),
        destinations: [
          const NavigationRailDestination(
              icon: Icon(
                CupertinoIcons.home,
                color: kPrimaryGreen,
              ),
              label: Text('home'),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
          const NavigationRailDestination(
              icon: Icon(
                CupertinoIcons.pen,
                color: kPrimaryGreen,
              ),
              label: Text('edit'),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
          const NavigationRailDestination(
              icon: Icon(
                CupertinoIcons.tray_arrow_up_fill,
                color: kPrimaryGreen,
              ),
              label: Text('output'),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
          const NavigationRailDestination(
              icon: Icon(
                CupertinoIcons.info,
                color: kPrimaryGreen,
              ),
              label: Text('about'),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
          NavigationRailDestination(
              icon: Text(
                '©K-Haga',
                style: captionText1.copyWith(color: kPrimaryGreen),
              ),
              label: const Text('copyright'),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
        ],
        selectedIndex: navState,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/edit');
              break;
            case 2:
              context.go('/output');
              // Navigator.pushNamed(context, '/config');
              break;
            case 3:
              context.go('/about');
              // Navigator.pushNamed(context, '/config');
              break;
          }

          setNav.change(index);
        });
  }
}
