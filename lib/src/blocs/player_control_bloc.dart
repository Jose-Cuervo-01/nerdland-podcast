import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:nerdland_podcast/src/models/podcast.dart';

class PlayerControlBloc {
  FlutterSound _flutterSound = FlutterSound();

  BehaviorSubject<PlayStatus> _playerStatusController = BehaviorSubject();
  BehaviorSubject<bool> _isPlayingController = BehaviorSubject();
  // The currently selected podcast
  // NOTE: this could be a string to just keep track of the url
  // But if we keep track of the Podcast we have acces to the title
  // to display in the player controls section
  BehaviorSubject<Podcast> _currentlyPlayingController = BehaviorSubject();

  StreamController<double> _currentlyVolume = StreamController.broadcast();

  Stream<PlayStatus> get playStatus$ => _playerStatusController.stream;
  Stream<bool> get isPlaying$ => _isPlayingController.stream;
  Stream<Podcast> get currentlyPlaying$ => _currentlyPlayingController.stream;
  Stream<double> get currentlyVolume$ {
    return _currentlyVolume.stream;
  }

  Podcast _podcast;
  double _volume = 1.0;

  void select(Podcast podcast) {
    print('Podcast with title ${podcast.title} was selected');
    _podcast = podcast;
    _currentlyPlayingController.add(_podcast);
    _currentlyVolume.add(_volume);
  }

  void selectAndPlay(Podcast podcast) {
    print('Podcast with title ${podcast.title} was selected');
    _podcast = podcast;
    _currentlyPlayingController.add(_podcast);
    play();
  }

  void play() async {
    await _flutterSound
        .startPlayer(_podcast.enclosure.url.replaceFirst('http', 'https'));
    _isPlayingController.add(true);
    _flutterSound.onPlayerStateChanged.listen((playStatus) {
      _playerStatusController.add(playStatus);
    });
    setVolume(_volume);
  }

  void stop() async {
    await _flutterSound.stopPlayer();
    _isPlayingController.add(false);
  }

  void seek(int milliSeconds) async {
    await _flutterSound.seekToPlayer(milliSeconds);
  }

  void pause() async {
    await _flutterSound.pausePlayer();
  }

  void setVolume(double volume) async {
    await _flutterSound.setVolume(volume);
    _volume = volume;
    _currentlyVolume.add(_volume);
  }

  void dispose() {
    _playerStatusController.stream.drain();
    _playerStatusController.close();
    _isPlayingController.stream.drain();
    _isPlayingController.close();
    _currentlyPlayingController.stream.drain();
    _currentlyPlayingController.close();
    _currentlyVolume.stream.drain();
    _currentlyVolume.close();
  }
}
