import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:nerdland_podcast/src/blocs/player_control_bloc.dart';
import 'package:nerdland_podcast/src/blocs/podcasts_bloc.dart';
import 'package:nerdland_podcast/src/models/podcast.dart';
import 'package:nerdland_podcast/src/screens/podcast_details.dart';
import 'package:nerdland_podcast/src/widgets/player/index.dart';
import 'package:nerdland_podcast/src/widgets/player/large/player_button_large.dart';
import 'package:nerdland_podcast/src/widgets/player/large/player_volume_slider.dart';
import 'package:provider/provider.dart';

class PlayerControlsLarge extends StatefulWidget {
  @override
  _PlayerControlsLargeState createState() => _PlayerControlsLargeState();
}

class _PlayerControlsLargeState extends State<PlayerControlsLarge> {
  PlayerControlBloc _playerControlBloc;
  PodcastsBloc _podcastsBloc;

  @override
  void didChangeDependencies() {
    _playerControlBloc = Provider.of<PlayerControlBloc>(context);
    _podcastsBloc = Provider.of<PodcastsBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _playerControlBloc.currentlyPlaying$,
      builder: (BuildContext context, AsyncSnapshot<Podcast> snapshot) {
        if (snapshot.hasData) {
          if (_playerControlBloc.selectedEqualsDetails()) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Column(children: [
                    ProgressSlider(
                      color: Theme.of(context).accentColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        StreamBuilder(
                          stream: _playerControlBloc.playStatus$,
                          builder: (BuildContext context,
                              AsyncSnapshot<PlayStatus> snapshot) {
                            if (snapshot.hasData) {
                              Duration duration = Duration(
                                  milliseconds:
                                      snapshot.data.currentPosition.toInt());
                              print(duration.inHours);
                              return Text(_printDuration(duration));
                            } else {
                              return Text('00:00');
                            }
                          },
                        ),
                        StreamBuilder(
                          stream: _playerControlBloc.currentlyPlaying$,
                          builder: (BuildContext context,
                              AsyncSnapshot<Podcast> snapshot) {
                            if (snapshot.hasData) {
                              return Text('${snapshot.data.itunes.duration}');
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      ],
                    ),
                  ]),
                ),
                Flexible(
                  flex: 4,
                  child: _buildPlayerControls(context),
                ),
                // Flexible(
                //   flex: 3,
                //   child: volumeSlider,
                // ),
              ],
            );
          }
        }
        return Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: FlatButton(
            color: Theme.of(context).accentColor,
            child: Text(
              'Afspelen',
            ),
            onPressed: () {
              _playerControlBloc.stop();
              _playerControlBloc.play();
            },
          ),
        );
      },
    );
  }

  Widget _buildPlayerControls(BuildContext context) {
    const iconPadding = 12.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.only(right: iconPadding),
              color: Colors.white70,
              icon: Icon(Icons.skip_previous),
              onPressed: () async {
                Podcast current =
                    await _playerControlBloc.currentlyPlaying$.first;
                Podcast previous = _podcastsBloc.previousPodcast(current);
                _playerControlBloc.select(previous);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    // Should remain state otherwise the bloc is closed
                    builder: (_) => PodcastDetails(
                          podcast: previous,
                        ),
                  ),
                );
              },
            ),
            PlayerButtonLarge(),
            IconButton(
              padding: EdgeInsets.only(left: iconPadding),
              icon: Icon(Icons.skip_next),
              color: Colors.white70,
              onPressed: () async {
                Podcast current =
                    await _playerControlBloc.currentlyPlaying$.first;
                Podcast next = _podcastsBloc.nextPodcast(current);
                _playerControlBloc.select(next);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    // Should remain state otherwise the bloc is closed
                    builder: (_) => PodcastDetails(
                          podcast: next,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget get volumeSlider {
    return PlayerVolumeSlider();
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
