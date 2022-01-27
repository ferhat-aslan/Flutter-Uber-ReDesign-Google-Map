import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loca;
import 'package:permission_handler/permission_handler.dart';
import 'package:uber_redesign/resultPage.dart';

class MapMaker extends StatefulWidget {
  const MapMaker({Key? key}) : super(key: key);

  @override
  _MapMakerState createState() => _MapMakerState();
}

class _MapMakerState extends State<MapMaker> {
  

  @override
  void initState() {
    super.initState();
  }

  @override
  

  _getLocation() async {
    loca.Location locali = loca.Location();
    try {
      currentLocation = await locali.getLocation();
      
      locali.onLocationChanged.listen((l) {
        
        controllerMap!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 19),
          ),
        );
      });
      
      setState(
          () {}); //rebuild the widget after getting the current location of the user
    } on Exception {
      
    }
  }

  GoogleMapController? controllerMap;
  loca.Location locali = loca.Location();
  String location = "Start";
  String target = "Stop";
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

  Set<Marker> _markers = {};

  CameraPosition? cameraPosition;

  loca.LocationData? currentLocation;

  @override
  Widget build(BuildContext context) {
    

    return SafeArea(
      child: Scaffold(
        bottomSheet: Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          child: TextButton(
            child: Text(
              'Search',
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ResultPage(_markers, location, target)));
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
              onCameraMove: (CameraPosition cameraPositiona) {
                cameraPosition = cameraPositiona; //when map is dragging
              },

              initialCameraPosition: CameraPosition(
                target:LatLng(37.06617199343901, 37.38320977987926),
                zoom: 15,
              ),
              myLocationEnabled: true,
              buildingsEnabled: true,
              zoomControlsEnabled: false,

              myLocationButtonEnabled: true,
              onLongPress: addMarker,
              markers: _markers,
               onMapCreated: _onMapCreated,
            ),
            Positioned(
                //widget to display location name
                bottom: 155,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Card(
                    elevation: 8,
                    child: Container(
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width - 40,
                        child: ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              location = "Start";
                              _markers.removeWhere((item)=>item.markerId==MarkerId("Start"));
                              setState(() {});
                            },
                            icon: Icon(Icons.delete),
                          ),
                          onTap: () {
                            //destination!.latitude!=cameraPosition!.target.latitude;
                            // destination!.longitude!=cameraPosition!.target.longitude;
                            setState(() {});
                          },
                          leading: Icon(
                            Icons.location_pin,
                            color: Colors.blue,
                          ),
                          title: Text(
                            !(location.length>21)?location:location.substring(0,20)+"...",
                            style: TextStyle(fontSize: 18),
                          ),
                          dense: true,
                        )),
                  ),
                )),
            Positioned(
                //widget to display location name
                bottom: 100,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Card(
                    elevation: 8,
                    child: Container(
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width - 40,
                        child: ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              target = "Stop";
                              _markers.removeWhere((item)=>item.markerId==MarkerId("Stop"));
                              setState(() {});
                            },
                            icon: Icon(Icons.delete),
                          ),
                          onTap: () {
                            //destination!.latitude!=cameraPosition!.target.latitude;
                            // destination!.longitude!=cameraPosition!.target.longitude;
                            setState(() {});
                          },
                          leading: Icon(
                            Icons.location_pin,
                            color: Colors.blue,
                          ),
                          title: Text(
                            !(target.length>21)?target:target.substring(0,20)+"...",
                            style: TextStyle(fontSize: 18),
                          ),
                          dense: true,
                        )),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void markerAdd(LatLng argument, BitmapDescriptor clr,String id) async {
    _markers.add(Marker(
      position: argument,
      markerId: MarkerId(id.toString()),
      infoWindow: const InfoWindow(title: 'Marker'),
      icon: clr,
    ));
    setState(() {});
  }

  void addMarker(LatLng argument) async {
    //when map drag stops
    List<Placemark> placemarks =
        await placemarkFromCoordinates(argument.latitude, argument.longitude);
    setState(() {
      if ((location == "Start")) {
        markerAdd(argument,
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),"Start");
        location = placemarks.first.street.toString() +
            ", " +
            placemarks.first.name.toString() +
            ", " +
            placemarks.first.postalCode.toString();
      } else if (!(location == "Start") && !(target == "Stop")) {
        _markers.clear();
        
        target = "Stop";
        markerAdd(argument,
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),"Start");
        location = placemarks.first.street.toString() +
            ", " +
            placemarks.first.name.toString() +
            ", " +
            placemarks.first.postalCode.toString();
      } else {
        markerAdd(argument,
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),"Stop");
        target = placemarks.first.street.toString() +
            ", " +
            placemarks.first.name.toString() +
            ", " +
            placemarks.first.postalCode.toString();
      }
    });
  }

  void startPoint(GoogleMapController _cntlr) async {
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
}
