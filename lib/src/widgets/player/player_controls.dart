import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/widgets/marquee_widget.dart';
import 'package:nerdland_podcast/src/widgets/player/player_button.dart';
import 'package:nerdland_podcast/src/widgets/player/player_control_title.dart';
import 'package:nerdland_podcast/src/widgets/player/player_time_stamp.dart';
import 'package:nerdland_podcast/src/widgets/player/progress_slider.dart';

class PlayerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: ProgressSlider(),
        ),
        Flexible(
          flex: 9,
          child: playerControls,
        ),
      ],
    );
  }

  Widget get playerControls {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: PlayerTimeStamp(),
              ),
              Flexible(
                flex: 6,
                child: MarqueeWidget(
                  direction: Axis.horizontal,
                  child: PlayerControlTitle(),
                ),
              ),
              Flexible(
                flex: 1,
                child: PlayerButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}