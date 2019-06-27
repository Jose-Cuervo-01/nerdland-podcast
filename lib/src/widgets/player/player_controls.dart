import 'package:flutter/material.dart';
import 'package:nerdland_podcast/src/widgets/marquee_widget.dart';
import 'package:nerdland_podcast/src/widgets/player/index.dart';

class PlayerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: ProgressSlider(
            color: Theme.of(context).primaryColor,
          ),
        ),
        Flexible(
          flex: 9,
          child: _buildPlayerControls(context),
        ),
      ],
    );
  }

  Widget _buildPlayerControls(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
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
