import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../../../widgets/common/google_map_dialog.dart';

class LocationScreen extends StatefulWidget {
  List<Restaurant>? restaurants = [];

  LocationScreen({this.restaurants, super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  //Set default LAT/LNG for map location
  LatLng initialLocation = const LatLng(37.422131, -122.084801);

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  Uint8List? unitList;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  List<Marker> markers = [];
    GoogleMapController? googleMapController;

  //Set default camera position with zoom value
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      showAllRestaurantOnMap();
    });
    super.initState();
  }

 //set restaurants list markers on map
 showAllRestaurantOnMap() async {
    await getBytesFromAsset();
    markers.clear();
    googleMapController = await _controller.future;

    if (widget?.restaurants != null && widget.restaurants?.isNotEmpty == true) {
      //here we animate first marker
      await googleMapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 10.0,
        target: LatLng(
            double.parse(widget?.restaurants?.first.latitude ?? "0.0"),
            double.parse(widget?.restaurants?.first.longitude ?? "0.0")),
      )));
      //set loop for adding mutliple markers from restaurants list
      widget?.restaurants?.forEach((element) {
        markers.add(Marker(
          onTap: () async {
            showDetailsDialog(element);
          },
          icon: BitmapDescriptor.fromBytes(unitList!),
          markerId: MarkerId(element.id.toString() ?? ""),
          position: LatLng(double.parse(element.latitude.toString() ?? "0.0"),
              double.parse(element.longitude.toString() ?? "0.0")),
        ));
      });
    }

    setState(() {});
  }

  //create custom map marker
  Future getBytesFromAsset() async {
    ByteData data = await rootBundle.load(iceMapImage);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 70);
    ui.FrameInfo fi = await codec.getNextFrame();
    unitList = (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
    setState(() {});
  }

 
// show mapview
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set<Marker>.from(markers),
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top + 20, left: 20),
                child: Image.asset(
                  backImage,
                  height: 25,
                  width: 25,
                )),
          )
        ],
      ),
    );
  }

  //show details for paricular restaurant marker
  showDetailsDialog(Restaurant? restaurant) {
    Get.dialog(GoogleMapDialog(
      restaurant:restaurant ,
      onDetailTab: () {
      
      },
      onMapTab: () async {
        Get.back();
        await MapsLauncher.launchCoordinates(
            double.parse(restaurant?.latitude.toString() ?? "0.0"),
            double.parse(restaurant?.longitude.toString() ?? "0.0"));
      },
    ));
  }

  @override
  void dispose() {
    if(googleMapController!=null){
      googleMapController?.dispose();
    }
    super.dispose();
  }
}
