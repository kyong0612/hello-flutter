import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterTts flutterTts = FlutterTts();
  final String _speakText =
      "寿限無、寿限無、五劫の擦り切れ 海砂利水魚（かいじゃりすいぎょ） の水行末 雲来末 風来末、 食う寝る処に住む処 やぶら小路の藪柑子 パイポ パイポ パイポのシューリンガン シューリンガンのグーリンダイ、 グーリンダイのポンポコピーのポンポコナーの 長久命の長助";

  Future<void> _speak() async {
    const String _lang = "ja-JP";
    await flutterTts.setLanguage(_lang);
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(_speakText);
  }

  Future<void> _stop() async {
    await flutterTts.stop();
  }

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
            Text(
              _speakText,
              style: Theme.of(context).textTheme.headlineSmall,
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _speak,
            child: const Icon(Icons.play_arrow),
          ),
          FloatingActionButton(
            onPressed: _stop,
            child: const Icon(Icons.stop),
          )
        ],
      ),
    );
  }
}
