import 'package:my_app/src/app.dart';
import 'package:my_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:my_app/src/features/map/presentation/home_app_bar/more_menu_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'features/authentication/auth_robot.dart';
import 'goldens/golden_robot.dart';

class Robot {
  Robot(this.tester)
      : auth = AuthRobot(tester),
        golden = GoldenRobot(tester);
  final WidgetTester tester;
  final AuthRobot auth;
  final GoldenRobot golden;

  Future<void> pumpMyApp() async {
    // Override repositories
    final authRepository = FakeAuthRepository(addDelay: false);
    // * Create ProviderContainer with any required overrides
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepository),
      ],
    );
    // * Entry point of the app
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> openPopupMenu() async {
    final finder = find.byType(MoreMenuButton);
    final matches = finder.evaluate();
    // if an item is found, it means that we're running
    // on a small window and can tap to reveal the menu
    if (matches.isNotEmpty) {
      await tester.tap(finder);
      await tester.pumpAndSettle();
    }
    // else no-op, as the items are already visible
  }

  // navigation
  Future<void> closePage() async {
    final finder = find.byTooltip('Close');
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> goBack() async {
    final finder = find.byTooltip('Back');
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }
}
