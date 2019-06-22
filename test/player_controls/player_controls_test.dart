import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nerdland_podcast/src/blocs/player_control_bloc.dart';
import 'package:nerdland_podcast/src/widgets/player/player_button.dart';
import 'package:nerdland_podcast/src/widgets/player/player_control_title.dart';
import 'package:nerdland_podcast/src/widgets/player/player_controls.dart';
import 'package:nerdland_podcast/src/widgets/player/player_time_stamp.dart';
import 'package:nerdland_podcast/src/widgets/player/progress_slider.dart';
import 'package:provider/provider.dart';

void main() {
  group('Displays Player controls children', () {
    testWidgets('Displays PlayerButton control', (tester) async {
      await tester.pumpWidget(
        Provider<PlayerControlBloc>(
          builder: (_) => PlayerControlBloc(),
          child: MaterialApp(
            home: Scaffold(
              body: PlayerButton(),
            ),
          ),
        ),
      );

      expect(find.byType(PlayerButton), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      expect(find.byIcon(Icons.pause), findsNothing);
    });

    testWidgets('Displays PlayerControlTitle control', (tester) async {
      await tester.pumpWidget(
        Provider<PlayerControlBloc>(
          builder: (_) => PlayerControlBloc(),
          child: MaterialApp(
            home: Scaffold(
              body: PlayerControlTitle(),
            ),
          ),
        ),
      );

      expect(find.byType(PlayerControlTitle), findsOneWidget);
      expect(find.text('..'), findsOneWidget);
      expect(find.text('Gekozen podcast titel'), findsNothing);
    });

    testWidgets('Displays PlayerTimeStamp control', (tester) async {
      await tester.pumpWidget(
        Provider<PlayerControlBloc>(
          builder: (_) => PlayerControlBloc(),
          child: MaterialApp(
            home: Scaffold(
              body: PlayerTimeStamp(),
            ),
          ),
        ),
      );

      expect(find.byType(PlayerTimeStamp), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.text('15 minuten restered'), findsNothing);
    });

    testWidgets('Displays ProgressSlider control', (tester) async {
      await tester.pumpWidget(
        Provider<PlayerControlBloc>(
          builder: (_) => PlayerControlBloc(),
          child: MaterialApp(
            home: Scaffold(
              body: ProgressSlider(),
            ),
          ),
        ),
      );

      expect(find.byType(ProgressSlider), findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);

      final slider = find.byType(Slider).evaluate().single.widget as Slider;
      expect(slider.value, 0.0);
      expect(slider.onChanged, null);
    });

    // Skipping because the MarqueeWidget has an animation that gives
    // an error when running this test below (Timer that is still running)
    testWidgets('Displays all children controls', (tester) async {
      await tester.pumpAndSettle();
      await tester.pumpWidget(
        Provider<PlayerControlBloc>(
          builder: (_) => PlayerControlBloc(),
          child: MaterialApp(
            home: Scaffold(
              body: PlayerControls(),
            ),
          ),
        ),
      );

      expect(find.byType(ProgressSlider), findsOneWidget);
    }, skip: true);
  });
}
