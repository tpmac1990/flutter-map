import 'package:my_app/src/constants/breakpoints.dart';
import 'package:my_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:my_app/src/features/map/presentation/home_app_bar/map_icon.dart';
import 'package:my_app/src/features/map/presentation/home_app_bar/more_menu_button.dart';
import 'package:my_app/src/localization/string_hardcoded.dart';
import 'package:my_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/common_widgets/action_text_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;
    // * This widget is responsive.
    // * On large screen sizes, it shows all the actions in the app bar.
    // * On small screen sizes, it shows only the shopping cart icon and a
    // * [MoreMenuButton].
    // ! MediaQuery is used on the assumption that the widget takes up the full
    // ! width of the screen. If that's not the case, LayoutBuilder should be
    // ! used instead.
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < Breakpoint.tablet) {
      return AppBar(
        title: Text('My Map'.hardcoded),
        actions: [
          const MapIcon(),
          MoreMenuButton(user: user),
        ],
      );
    } else {
      return AppBar(
        title: Text('My Map'.hardcoded),
        actions: [
          // const ShoppingCartIcon(),
          if (user != null) ...[
            
          ] else
            ActionTextButton(
              key: MoreMenuButton.signInKey,
              text: 'Sign In'.hardcoded,
              onPressed: () => context.goNamed(AppRoute.signIn.name),
            )
        ],
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

