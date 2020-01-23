import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  final FlutterTts tts = FlutterTts();

  Future speak(String text) async {
    await tts.setLanguage("en-us");
    await tts.setPitch(0.9);
    await tts.speak(text);
  }

}