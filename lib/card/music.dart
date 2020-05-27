import 'package:audioplayers/audio_cache.dart';

abstract class Music{
  static AudioCache _cache = AudioCache();

  static void playInvalidMove(){
    _cache.play('invalidMove.wav');
  }
  static void playLogs(){
    _cache.play('logs.wav');
  }
  static void playGameEnd(){
    _cache.play('gameend.wav');
  }
  static void playRegular(){
    _cache.play('regular.wav');
  }
  static void playSpecial(){
    _cache.play('special.wav');
  }
}