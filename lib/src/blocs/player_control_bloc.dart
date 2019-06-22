import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:nerdland_podcast/src/models/podcast.dart';

class PlayerControlBloc {
  FlutterSound _flutterSound = FlutterSound();

  StreamController<PlayStatus> _playerStatusController =
      StreamController.broadcast();
  StreamController<bool> _isPlayingController = StreamController.broadcast();
  // The currently selected podcast
  // NOTE: this could be a string to just keep track of the url
  // But if we keep track of the Podcast we have acces to the title
  // to display in the player controls section
  StreamController<Podcast> _currentlyPlayingController =
      StreamController.broadcast();

  Stream<PlayStatus> get playStatus$ =>
      _playerStatusController.stream.asBroadcastStream();
  Stream<bool> get isPlaying$ =>
      _isPlayingController.stream.asBroadcastStream();
  Stream<Podcast> get currentlyPlaying$ =>
      _currentlyPlayingController.stream.asBroadcastStream();

  Podcast _podcast;

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

  void dispose() {
    _playerStatusController.stream.drain();
    _playerStatusController.close();
    _isPlayingController.stream.drain();
    _isPlayingController.close();
    _currentlyPlayingController.stream.drain();
    _currentlyPlayingController.close();
  }
}
