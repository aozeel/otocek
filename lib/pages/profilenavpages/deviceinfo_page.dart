import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
class DeviceInfoPage  extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<DeviceInfoPage> {
  // save in the state for caching!
  DeviceInfoPlugin _deviceInfoPlugin;

  @override
  void initState() {
    super.initState();
    _deviceInfoPlugin = DeviceInfoPlugin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cihaz Bilgileri'),
        ),
        body: FutureBuilder<AndroidDeviceInfo>(
          future: _deviceInfoPlugin.androidInfo,
          builder: (BuildContext context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
            if (!snapshot.hasData) {
              // while data is loading:
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // data loaded:
              final androidDeviceInfo = snapshot.data;
              return Center(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.branding_watermark),
                        title: Text("Marka ${androidDeviceInfo.brand}"),
                      ),
                      ListTile(
                        leading: Icon(Icons.branding_watermark),
                        title: Text("Model ${androidDeviceInfo.model}"),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      );
  }
}