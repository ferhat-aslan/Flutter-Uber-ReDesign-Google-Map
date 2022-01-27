import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loca;
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber_redesign/last.dart';

class ResultPage extends StatefulWidget {
  Set<Marker> markers;
  String location;
  String target;
  ResultPage(this.markers, this.location, this.target);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  void initState() {
    super.initState();
  }

  GoogleMapController? controllerMap;
  loca.Location locali = loca.Location();
  // _getLocation() async {
  //   loca.Location locali = loca.Location();
  //   try {
  //     currentLocation = await locali.getLocation();
  //     locali.onLocationChanged.listen((l) {
  //       controllerMap!.animateCamera(
  //         CameraUpdate.newCameraPosition(
  //           CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 19),
  //         ),
  //       );
  //     });

  //     setState(
  //         () {}); //rebuild the widget after getting the current location of the user
  //   } on Exception {}
  // }

   void _onMapCreated(GoogleMapController _cntlr) async {
    currentLocation = await locali.getLocation();
    controllerMap = _cntlr;
    locali.onLocationChanged.listen((l) {
      controllerMap!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  CameraPosition? cameraPosition;

  loca.LocationData? currentLocation;
  @override
  Widget build(BuildContext context) {
    var genislik = MediaQuery.of(context).size.width;

    var yukseklik = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      bottomSheet: Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          child: Text(
            'Book Now',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>LastPage(widget.markers, widget.location, widget.target)));
          },
        ),
      ),
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: Text("Uber"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.notification_important_outlined))
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black87.withOpacity(0.5),
      ),
      body: Stack(
        children: [
          GoogleMap(
           // onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            onCameraMove: (CameraPosition cameraPositiona) {
              cameraPosition = cameraPositiona; //when map is dragging
            },

            initialCameraPosition: CameraPosition(
              target: LatLng(currentLocation?.latitude ?? 37.06617199343901,
                  currentLocation?.longitude ??  37.38320977987926),
              zoom: 15,
            ),
            myLocationEnabled: true,
            buildingsEnabled: true,

            myLocationButtonEnabled: true,

            markers: widget.markers,
            //  onMapCreated: _onMapCreated,
          ),
          Positioned(
              //widget to display location name
              bottom: 275,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Card(
                  elevation: 8,
                  child: Container(
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width - 40,
                      child: ListTile(
                        onTap: () {
                          //destination!.latitude!=cameraPosition!.target.latitude;
                          // destination!.longitude!=cameraPosition!.target.longitude;
                        },
                        leading: Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                        ),
                        title: Text(
                          !(widget.location.length > 21)
                              ? widget.location
                              : widget.location.substring(0, 20) + "...",
                          style: TextStyle(fontSize: 18),
                        ),
                        dense: true,
                      )),
                ),
              )),
          Positioned(
              //widget to display location name
              bottom: 210,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Card(
                  elevation: 8,
                  child: Container(
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width - 40,
                      child: ListTile(
                        onTap: () {
                          //destination!.latitude!=cameraPosition!.target.latitude;
                          // destination!.longitude!=cameraPosition!.target.longitude;
                        },
                        leading: Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                        ),
                        title: Text(
                          !(widget.target.length > 21)
                              ? widget.target
                              : widget.target.substring(0, 20) + "...",
                          style: TextStyle(fontSize: 18),
                        ),
                        dense: true,
                      )),
                ),
              )),
          Positioned(
            bottom: 120,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(19),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    width: genislik * 0.24,
                    height: yukseklik * 0.24,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        Icon(
                          Icons.car_rental,
                          size: 55,
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Taxi",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text("\$35",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
                        SizedBox(height: 2),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(19),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    width: genislik * 0.24,
                    height: yukseklik * 0.24,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        Icon(
                          Icons.car_rental,
                          size: 55,
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Taxi",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text("\$35",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
                        SizedBox(height: 2),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(19),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    width: genislik * 0.24,
                    height: yukseklik * 0.24,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        Icon(
                          Icons.car_rental,
                          size: 55,
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Taxi",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text("\$35",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
                        SizedBox(height: 2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 60,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: genislik * 0.67,
                      height: yukseklik * 0.11,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Coupon",
                            contentPadding: EdgeInsets.only(left: 15)),
                      ),
                    ),
                    Container(
                        width: genislik * 0.24,
                        height: yukseklik * 0.11,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)))
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
