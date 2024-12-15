import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice Record ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? filePath;
  AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a', 'aac'],
    );

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
      });
    }
  }

  Future<void> playAudio() async {
    if (filePath != null) {
      await _audioPlayer.play(DeviceFileSource(filePath!));
    }
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:Icon(Icons.mic_rounded,color:Colors.red),
        title: Text('Voice Record ',),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: pickFile,
              child: Text('Pick Voice Record'),
            ),
            SizedBox(height: 20),
            filePath != null ? Text('Selected file: $filePath') : Text('No file selected'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: playAudio,
                  child: Text('Play'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: stopAudio,
                  child: Text('Stop'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
