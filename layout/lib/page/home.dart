import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/page/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

//https://docs.flutter.dev/development/ui/layout
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("แอปอุปกรณ์การแพทย์"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder(
              builder: (context, AsyncSnapshot snapshot) {
                //var data = json.decode(snapshot.data.toString()); //[{},{},{}]
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return MyBox(snapshot.data[index]['title'], snapshot.data[index]['subtitle'],
                        snapshot.data[index]['image_url'], snapshot.data[index]['detail']);
                  },
                  itemCount: snapshot.data.length,
                );
              },
              //future:DefaultAssetBundle.of(context).loadString('assets/data.json'),
              future: getData(),
            )));
  }

  Widget MyBox(String title, String subtitle, String image_url, String detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(20),
      height: 150,
      decoration: BoxDecoration(
          //color: Colors.amber[100],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(image_url),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.30), BlendMode.lighten))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              print("Next Page >>>");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(v1, v2, v3, v4)));
            },
            child: Text("อ่าานต่อ", style: TextStyle(fontSize: 20)),
          )
        ],
      ),
    );
  }

  //async ดึงข้อมูลมาจาก internet
  Future getData() async {
    //https://raw.githubusercontent.com/banditphiboon/BasicAPI/main/data.json
    var url = Uri.https(
        'raw.githubusercontent.com', '/banditphiboon/BasicAPI/main/data.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
}
