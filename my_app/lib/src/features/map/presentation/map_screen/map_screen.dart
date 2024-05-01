import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/src/features/map/presentation/home_app_bar/home_app_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_screen.g.dart';

@riverpod
class MapCompleter extends _$MapCompleter {
  @override
  Completer<GoogleMapController> build() {
    return Completer();
  }

  void addController(controller) {
    state.complete(controller);
  }
}

class MapScreen extends ConsumerWidget {
  const MapScreen({Key? key}) : super(key: key);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10.0,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: const HomeAppBar(),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomControlsEnabled: false,
              compassEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (controller) {
                ref.read(mapCompleterProvider.notifier).addController(controller);
              },
              // markers: newMarkers,
              mapType: MapType.normal, // hybrid, satellite, terrain
              onTap: (LatLng latLng) {}
            ),
          ),
        ]
      ),
    );
  }
}