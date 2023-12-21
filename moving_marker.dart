import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:google_map_marker_animation/widgets/animarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/util/dialog_helper.dart';
import '../../../app/util/export_file.dart';
import '../../../data/models/api_date_model.dart';
import '../../../data/repositories/map_provider/impl/remote_map_provider.dart';
import '../../../data/repositories/map_provider/interface/imap_repository.dart';

class LocationMovingMarkerScreen extends StatefulWidget {
  var deviceId;

  LocationMovingMarkerScreen({this.deviceId, super.key});

  @override
  SimpleMarkerAnimationExampleState createState() =>
      SimpleMarkerAnimationExampleState();
}

class SimpleMarkerAnimationExampleState
    extends State<LocationMovingMarkerScreen> {
  final markers = <MarkerId, Marker>{};
  GoogleMapController? googleMapController;
  var initialPosition;
  final controller = Completer<GoogleMapController>();
  Stream<LatLng>? stream;


  bool isLoading = true;
  List<ApiDataModel>? deviceTractList = [];
  IMapRepository? iMapRepository;
  List<LatLng> _polylineCoordinates = [LatLng(30.7046, 76.7179)];
  final PolylineId _polylineId = PolylineId("polyline");
  List<LatLng> finalList = [];
  CameraPosition? currentCameraPosition;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      iMapRepository = Get.put(RemoteIMapProvider());
      hitApiToGetDeviceTrackList();
    });
    super.initState();
  }


  //here we  get list of latitude and longitude
  Future hitApiToGetDeviceTrackList() async {
    deviceTractList?.clear();
    DialogHelper.showLoading();
    await iMapRepository
        ?.getDeviceTrackingData(map: {"id": widget.deviceId}).then((value) {
      DialogHelper.hideLoading();
      if (value != null && value.data != null) {
        deviceTractList?.addAll(value.data?.result ?? []);
        finalList.clear();
        deviceTractList?.forEach((element) {
          finalList.add(LatLng(element.lat, element.lng));
        });
        initialPosition = CameraPosition(target: finalList.first, zoom: 18.0);
        _polylineCoordinates.clear();
        _polylineCoordinates?.addAll(finalList);
        markers[MarkerId('MarkerId1')] = Marker(
          markerId: MarkerId('MarkerId1'),
          position: finalList.first,
        );
      }

      setState(() {
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      DialogHelper.hideLoading();
      showToast(message: error?.toString());
      setState(() {
        isLoading = false;
      });
    });
  }


  //here we add streams for moving marker on map
  showDifferentRestaurants() async {
    if (finalList != null && finalList?.isNotEmpty == true) {
      stream =
          Stream.periodic(Duration(seconds: 2), (count) => finalList[count])
              .take(finalList.length);
      stream?.forEach((value) => newLocationUpdate(value));

      if(mounted)setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.tractDetails,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          AppPngAssets.moveImage,
          color: Colors.white,
          height: 25.h,
          width: 25.w,
        ),
        backgroundColor: AppColors.primary,
        onPressed: () {
          showDifferentRestaurants();
        },
      ),
      body: isLoading
          ? Container(
              height: 50.h,
              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              color: AppColors.primary.withOpacity(0.8),
              child: Center(
                child: Text(
                  isLoading == true
                      ? AppStrings.loading
                      : AppStrings.noTrackData,
                  style: TextStyle(
                      color: AppColors.white, fontWeight: FontWeight.w400),
                ),
              ))
          : Stack(
        children: [
          Animarker(
            shouldAnimateCamera: false,
            zoom: 18.0,
            curve: Curves.linear,
            mapId: controller.future.then<int>((value) => value.mapId),
            //Grab Google Map Id
            markers: markers.values.toSet(),
            child: GoogleMap(
              polylines: {
                Polyline(
                  polylineId: _polylineId,
                  color: Colors.red,
                  width: 2,
                  points: _polylineCoordinates,
                ),
              },
              mapType: MapType.normal,

              onCameraMove: (CameraPosition? cameraPosition) {
                currentCameraPosition = cameraPosition;
               if(mounted)  setState(() {});
              },
              initialCameraPosition: initialPosition,
              onMapCreated: (gController) {
                googleMapController=gController;
               controller.complete(gController);
              }, //Complete the future GoogleMapController
            ),
          ),
          deviceTractList?.length == 0
              ? Container(
            width: double.infinity,
            height: 50.h,
            padding: EdgeInsets.all(10.r),
            color: AppColors.primary.withOpacity(0.8),
            child: Center(
              child: Text(
                isLoading == true
                    ? AppStrings.loading
                    : AppStrings.noTrackData,
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.w400),
              ),
            ),
          )
              : SizedBox(),
        ],
      ),
    );
  }

  //this method move marker and animate camera

  Future<void> newLocationUpdate(LatLng latLng) async {
    print("check the camear bearing ${currentCameraPosition?.zoom}");

     var marker = Marker(
      markerId: MarkerId('MarkerId1'),
      position: latLng,
    );
    googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      zoom: currentCameraPosition == null
          ? 18.0
          : currentCameraPosition?.zoom ?? 18.0,
      target: latLng,
    )));
    if (mounted)
      setState(() {
        markers[MarkerId('MarkerId1')] = marker;
      });
  }



  //here we dispose the map

  disposeMap() async {
    googleMapController?.dispose();
}


  @override
  void dispose() {
    disposeMap();
    // TODO: implement dispose
    super.dispose();
  }
}
