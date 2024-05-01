import 'package:my_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Map icon
class MapIcon extends ConsumerWidget {
  const MapIcon({super.key});

  // * Keys for testing using find.byKey()
  static const MapIconKey = Key('map');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Center(
          child: IconButton(
            key: MapIconKey,
            icon: const Icon(Icons.map),
            onPressed: () => context.goNamed(AppRoute.map.name),
          ),
        ),
      ],
    );
  }
}
