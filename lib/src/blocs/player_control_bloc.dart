import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:nerdland_podcast/src/models/podcast.dart';

class PlayerControlBloc {
  Podcast _selectedPodcast;
  double _volume = 1.0;

  FlutterSound _flutterSound = FlutterSound();

  BehaviorSubject<PlayStatus> _playerStatusController = BehaviorSubject();
  BehaviorSubject<bool> _isPlayingController = BehaviorSubject();

  /// Keeps track of the currently playing [Podcast]
  BehaviorSubject<Podcast> _currentlyPlayingController = BehaviorSubject();

  /// Keeps track of the current selected [Podcast] on the details page
  BehaviorSubject<Podcast> _currentlySelectedController = BehaviorSubject();
  BehaviorSubject<double> _currentlyVolume = BehaviorSubject();

  Stream<PlayStatus> get playStatus$ => _playerStatusController.stream;
  Stream<bool> get isPlaying$ => _isPlayingController.stream;
  Stream<Podcast> get currentlyPlaying$ => _currentlyPlayingController.stream;
  Stream<Podcast> get currentlySelected$ => _currentlySelectedController.stream;
  Stream<double> get currentlyVolume$ => _currentlyVolume.stream;

  void select(Podcast podcast, [bool startPlaying = false]) {
    _selectedPodcast = podcast;
    _currentlySelectedController.add(_selectedPodcast);
    _currentlyVolume.add(_volume);
    if (startPlaying) {
      play();
    }
  }

  void play() async {
    if (_flutterSound.isPlaying) {
      await _flutterSound.resumePlayer();
    } else {
      await _flutterSound.startPlayer(
          _selectedPodcast.enclosure.url.replaceFirst('http', 'https'));
    }
    setVolume(_volume);
    _isPlayingController.add(true);
    _currentlyPlayingController.add(_selectedPodcast);
    _flutterSound.onPlayerStateChanged.listen((playStatus) {
      _playerStatusController.add(playStatus);
    });
  }

  void pause() async {
    await _flutterSound.pausePlayer();
    _isPlayingController.add(false);
  }

  void stop() async {
    if (_flutterSound.isPlaying == true) {
      await _flutterSound.stopPlayer();
    }
    _isPlayingController.add(false);
    _currentlyPlayingController.drain();
  }

  void seek(int milliSeconds) async {
    await _flutterSound.seekToPlayer(milliSeconds);
  }

  void setVolume(double volume) async {
    await _flutterSound.setVolume(volume);
    _volume = volume;
    _currentlyVolume.add(_volume);
  }

  bool selectedEqualsDetails() {
    return _currentlyPlayingController.value ==
        _currentlySelectedController.value;
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
    _currentlySelectedController.drain();
    _currentlySelectedController.close();
    _flutterSound.stopPlayer();
  }
}
