import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController _controller;

  MapType _currentType=MapType.normal;

  Position position;
  bool progress;
  Widget _child;

  @override

  void initState()
  {
    _child=CircularProgressIndicator();
    getCurrentLocation();
        super.initState();
      }

      void getCurrentLocation() async {

        Position res= await Geolocator().getCurrentPosition();

        setState(() {
          
          position=res;
          progress=true;

        });
      }

      Set<Marker> _createMarker(){
        return <Marker>[
          Marker(
            markerId: MarkerId('home'),
            position: LatLng(position.latitude, position.longitude),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title:'Home'),
            )
        ].toSet();
      }
    
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text('Maps Sample App'),
              backgroundColor: Colors.green[700],
            ),
            body: progress==false ? _child : Stack(
          children:<Widget>[

            GoogleMap(
          myLocationButtonEnabled: true,

          mapType: _currentType,
          markers: _createMarker(),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(position.latitude,position.longitude),
                zoom: 11.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:<Widget>[
                FloatingActionButton(
              backgroundColor: Colors.green[700],
              onPressed: (){

                setState(() {

                  _currentType=_currentType==MapType.normal?MapType.terrain:MapType.normal;
                  
                });

                
              },
              child: Icon(Icons.map),
              
              )

              ]
            )

          ]
        ),
          ),
        );
      }

    
      
}
