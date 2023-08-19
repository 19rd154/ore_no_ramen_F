import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key}) : super(key: key);

  @override
  State<MapViewScreen> createState() => MapViewScreenState();
}

class MapViewScreenState extends State<MapViewScreen> {
  Position? currentPosition;
  Set<Marker> markers = {}; // マーカーを保持するセット
  LatLng currentLatLng = LatLng(35.6895, 139.6917); // 初期位置

  late GoogleMapController _controller;
  late StreamSubscription<Position> positionStream;
  //初期位置
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(36.1953, 139.9011),
    zoom: 14,
  );

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high, //正確性:highはAndroid(0-100m),iOS(10m)
    distanceFilter: 100,
  );

  @override
  void initState() {
    super.initState();

    //位置情報が許可されていない時に許可をリクエストする
    Future(() async {
      LocationPermission permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){
        await Geolocator.requestPermission();
      }
    });

    //現在位置を更新し続ける
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
          currentPosition = position;
          print(position == null
              ? 'Unknown'
              : '${position.latitude.toString()}, ${position.longitude.toString()}');
        });

    // 現在位置を取得し、カメラの位置を更新する
    Geolocator.getCurrentPosition().then((Position position) {
      currentPosition = position;
      LatLng initialLatLng = LatLng(position.latitude, position.longitude);
      _updateCameraPosition(initialLatLng); // カメラの位置を更新
    });
  }

  void _updateCameraPosition(LatLng latLng) {
    CameraPosition newCameraPosition = CameraPosition(
      target: latLng,
      zoom: 14,
    );

    _controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  void _updateMarker(LatLng latLng) {
    setState(() {
      markers = {}; // 一旦すべてのマーカーをクリア
      markers.add(
        Marker(
          markerId: MarkerId(latLng.toString()),
          position: latLng,
        ),
      );
      currentLatLng = latLng; // 現在位置を更新
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          appBar: AppBar(
            title: const Text('Navigation'),
            backgroundColor: Colors.green[700],
              automaticallyImplyLeading:true,
              actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => {
                Navigator.pop(
                  context,
                  currentLatLng
                )
              },
            ),
          ]
          ),
          body:GoogleMap(
            markers: markers,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,//現在位置をマップ上に表示
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            onTap: (LatLng latLng) {
              _updateMarker(latLng);
            },
          ),
        );
    }
}

