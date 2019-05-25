import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intenciones',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Intenciones'),
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
  static const platform = const MethodChannel('sendSms');
  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () => launch("tel://4111008552"),
              child: Text("Llamar"),
            ),
            FlatButton(
              onPressed: () => sendSms(),
              child: Text("Mandar Mensaje"),
            ),
            FlatButton(
              onPressed: () => sendEmail("15030089@itcelaya.edu.mx", "Intencion", "Wenaaaaa"),
              child: Text("Mandar Correo"),
            ),
            FlatButton(
              onPressed: () => sendWhats("+524613124915"),
              child: Text("Mandar Whats"),
            ),
            FlatButton(
              onPressed: () => openMap(20.5409757, -100.8128918),
              child: Text("Abrir Google Maps"),
            ),
            FlatButton(
              onPressed: () => openExplorer(),
              child: Text("Abrir Navegador"),
            ),
            FlatButton(
              onPressed: () => camara(),
              child: Text("Seleccionar Camára"),
            ),
            FlatButton(
              onPressed: () => galeria(),
              child: Text("Seleccionar Galeria"),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> sendSms() async {
    print("SendSMS");
    try {
      final String result = await platform.invokeMethod(
          'send', <String, dynamic>{
        "phone": "+524111008552",
        "msg": "Khe Onda Kmarada"
      });
      print(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  sendEmail(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }


  sendWhats(String phone) async {
    String whats =
        'whatsapp://send?phone=$phone&text=Wenas Noches';
    if (await canLaunch(whats)) {
      await launch(whats);
    } else {
      throw 'No se pudo abrir la app';
    }
  }


  openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'No se pudo abrir Google Maps';
    }
  }

  openExplorer() async {
    String googleUrl =
        'https://www.google.com/search?q=hola&oq=hola';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'No se pudo abrir el navegador';
    }
  }

  camara() async {
    print('Camára');
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }
  galeria() async {
    print('Galeria');
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }


}
