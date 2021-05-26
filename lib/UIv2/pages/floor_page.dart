import 'package:animations/animations.dart';
import 'package:clarity/UI/widgets/bottom_menu_bar.dart';
import 'package:clarity/UIv2/pages/floor_ViewModel.dart';
import 'package:clarity/UIv2/pages/home_page.dart';
import 'package:clarity/app/app.locator.dart';
import 'package:clarity/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FloorPage extends StatelessWidget {
  const FloorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FloorViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: model.reverse,
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
            );
          },
          child: getViewForIndex(model.currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: KColors.background,
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home_outlined, color: KColors.icon),
              activeIcon: Icon(Icons.home_outlined, color: KColors.primary),
              tooltip: "home",
            ),
            BottomNavigationBarItem(
              label: "Browse",
              icon: Icon(Icons.bookmark_border_rounded, color: KColors.icon),
              activeIcon: Icon(Icons.home_outlined, color: KColors.primary),
              tooltip: "browse",
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person_outline_rounded, color: KColors.icon),
              activeIcon: Icon(Icons.home_outlined, color: KColors.primary),
              tooltip: "profile",
            ),
          ],
        ),
      ),
      viewModelBuilder: () => FloorViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return HomePage();
      default:
        return HomePage();
    }
  }
}
