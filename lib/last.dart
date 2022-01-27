import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loca;
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
class LastPage extends StatefulWidget {
 Set<Marker> markers;
  String location;
  String target;
  LastPage(this.markers, this.location, this.target);

  @override
  _LastPageState createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
   GoogleMapController? controllerMap;
  loca.Location locali = loca.Location();
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
    var genislik=MediaQuery.of(context).size.width;
    var yukseklik=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomSheet: Container(
        color: Colors.orangeAccent,
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          child: Text(
            'Cancel Driver',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>LastPage()));
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
              top: 45,
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
              top: 100,
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
              /////////////////////
          Positioned(
            bottom: 140,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 55,
                decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(19),boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [SizedBox(width:1),Icon(Icons.speaker),
                  Text("Ho Nguyon Vu",style:TextStyle(fontWeight:FontWeight.bold)),SizedBox(width:5),
                  Container(child:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.star),Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),Icon(Icons.star_border),],)),
                  ]),
              ),
            ),
          ),
          ////// wn ALT
          Positioned(
              bottom: 80,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Container(
                  height: 45,
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
                        child: Center(child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.car_repair),
                            Text("BR 56-N78",style:TextStyle(fontSize:18)),
                          ],
                        )),
                      ),
                      Container(
                        child:Row(
                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[Icon(Icons.phone,color: Colors.white),Text("Call",style:TextStyle(color: Colors.white,fontWeight:FontWeight.bold))]),
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
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)))
                    ],
                  ),
                ),
              ))
        ],
      ),
      ),
      
    );
  }
}