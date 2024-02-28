import 'package:flutter/material.dart';
import 'package:flutter_task/webview_screen.dart';



class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _url = '';
  String _selectedDevice = 'Wi-Fi'; // Default selected device

  List<String> _devices = ['Wi-Fi', 'Bluetooth', 'USB']; // Sample devices

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Enter URL'),
              onChanged: (value) {
                setState(() {
                  _url = value;
                });
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              value: _selectedDevice,
              items: _devices.map((device) {
                return DropdownMenuItem(
                  value: device,
                  child: Text(device),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDevice = value.toString();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Select Device',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewPage(url: _url),
                  ),
                );
              },
              child: Text('Save and Continue'),
            ),
          ],
        ),
      ),
    );
  }
}