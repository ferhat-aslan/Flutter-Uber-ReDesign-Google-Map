import 'package:flutter/material.dart';
import 'package:uber_redesign/mapMaker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var genislik=MediaQuery.of(context).size.width;
        var yukseklik=MediaQuery.of(context).size.height;

    return Scaffold(
      bottomSheet: Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          child: Text('Continue',style: TextStyle(color: Colors.white,fontSize: 23),),
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>MapMaker()));},
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: yukseklik*0.5,
            child: Center(
              child: Text("Uber",style: TextStyle(fontSize: 75,color: Colors.white),),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(39),
                    bottomRight: Radius.circular(39)),
                image: DecorationImage(
                    image: AssetImage('assets/images/photo.png'),fit: BoxFit.fitWidth)),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Get a ride in minutes.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Uber is finding you better ways to move, work, and succeed",
              style: TextStyle(fontSize: 21,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Material(
              elevation: 5,
              child: TextField(
                
                decoration: InputDecoration(
                  
                  contentPadding: EdgeInsets.all(15),
                  fillColor: Colors.white,
                  prefixIcon: Icon(
            Icons.account_circle,
            color: Colors.black45,
          ),
                  //icon: Icon(Icons.phone),
                  hintText: "Type your phone here",
                ),
              ),
            ),
          ),
          RichText(
            textAlign: TextAlign.center,text: TextSpan(
            
            children: [
              TextSpan(text: "I agree to ",style: TextStyle(color: Colors.black)),
              TextSpan(text: "Terms of Use", style: TextStyle(color: Colors.blue)),
              TextSpan(text: " & acknowledge\n that I have read the ",style: TextStyle(color: Colors.black),),
                            TextSpan(text: "Privacy Policy.", style: TextStyle(color: Colors.blue)),

              
            ],
          ),),
          
        ],
      ),
    );
  }
}
