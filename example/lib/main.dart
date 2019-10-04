import 'package:flutter/material.dart';
import 'package:japan_postal_code/japan_postal_code.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Japan Postal Code'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final zipCode = TextEditingController();
  String pref = "";
  String city = "";
  String town = "";

  @override
  void initState() {
    super.initState();
    zipCode.text = "0640941";
  }

  findZipCode() async{
    final japanPostCode = await JapanPostCode.getInstance();
    final data = await japanPostCode.getJapanPostalCode(zipCode.text);
    print(data.toString());
    setState(() {
      pref = "${data[0]['pref']}" ;
      city = "${data[0]['city']}";
      town = "${data[0]['town']}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 50,
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: zipCode,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 200,
              height: 50,
              child: MaterialButton(
                child: Text("Find Zipcode"),
                onPressed: findZipCode,
              ),
            ),
            Container(
              child: Text("Pref: ${this.pref}"),
            ),
            Container(
              child: Text("City: ${this.city}"),
            ),
            Container(
              child: Text("Town: ${this.town}"),
            )
          ],
        ),
      ),
    );
  }
}
