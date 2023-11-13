import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  stt.SpeechToText speech = stt.SpeechToText();

  // 音声入力開始
  Future<void> _speak() async {
    bool available = await speech.initialize(
      onStatus: statusListener,
      onError: errorListener,
    );
    if (available) {
      speech.listen(
        onResult: resultListener,
      );
    } else {
      print('The user has denied the use of speech recognition.');
    }
  }

  // 音声入力停止
  Future<void> _stop() async {
    speech.stop();
  }

  // リザルトリスナー
  void resultListener(SpeechRecognitionResult result) {
    print('Received result: ${result.recognizedWords}');
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  // エラーリスナー
  void errorListener(SpeechRecognitionError error) {
    print('Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  // ステータスリスナー
  void statusListener(String status) {
    print(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = status;
    });
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
              '変換文字: $lastWords',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'ステータス: $lastStatus',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
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
