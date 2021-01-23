import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:audiobook/util/util.dart';
import 'package:audiobook/model/post.dart';
import 'package:audiobook/util/constants.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audiobook/util/file_handler.dart';
import 'package:audiobook/util/network_operations.dart';
import 'package:audiobook/repository/media_player_repository.dart';

class MediaDetailWidget extends StatefulWidget {
  final _post;
 
  MediaDetailWidget(this._post); // will mainly be instantiated from the route logic

  final _MediaDetailWidgetState state = new _MediaDetailWidgetState(null);
 // change media when pressing on a different item
  void change(Post post) {
    if(this._post == null || post.id != this._post.id) {
      state.changeMedia(post);
    }
  }

  @override
  _MediaDetailWidgetState createState() => state;
}

class _MediaDetailWidgetState extends State<MediaDetailWidget> {
  Post _post;

  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  String localFilePath;
  MediaPlayerRepository repository = new MediaPlayerRepository();

  // initial player state
  AudioPlayerState playerState = AudioPlayerState.STOPPED;

  get isPlaying => playerState == AudioPlayerState.PLAYING;
  get isPaused => playerState == AudioPlayerState.PAUSED;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '00:00';
  get positionText =>
      position != null ? position.toString().split('.').first : '00:00';

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  Util util = Util();
  FileHandler fileHandler = FileHandler();
  NetworkOperations networkOperations = NetworkOperations();

  _MediaDetailWidgetState(this._post);

  // change the playing media
  void changeMedia(Post post) async {
   await stop();
   setState(() {
     this._post = post;
   }); 
   await play(context);
  }

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  void initAudioPlayer() {
    try {
      //AudioPlayer.logEnabled = true;
      audioPlayer = new AudioPlayer();
      subscribeToPositionAndDurationEvent();
    } catch (e) {
      log(e);
    }
  }

  /// Play from local_file if already downloaded or else from url provided
  Future play(BuildContext context) async {
    try {
      final connected = await networkOperations.isConnectedToInternet();
      if (!connected) {
        showSnakBar(context, Constants.NO_INTERNET_CONNECTION_ERROR);
        return;
      }

      //seek back to start
      if (position == duration) {
        position = new Duration(seconds: 0);
      }
      await audioPlayer.play(_post.url, isLocal: _post.isDownloaded, respectSilence: true, stayAwake: true);
      setState(() {
        playerState = AudioPlayerState.PLAYING;
      });
    } catch (e) {
      print("Error play(): $e");
    }
  }

  Future pause() async {
    try {
      await audioPlayer.pause();
      setState(() => playerState = AudioPlayerState.PAUSED);
    } catch (e) {
      print("Error pause(): $e");
    }
  }

  Future stop() async {
    try {
      await audioPlayer.stop();
      setState(() {
        position = new Duration();
        playerState = AudioPlayerState.STOPPED;
      });
    } catch (e) {
      print("Error stop(): $e");
    }
  }

  void onComplete() {
    try {
      // mark as opened
      repository.updatePostOpened(_post.id, _post.categoryId);

      setState(() {
        position = new Duration();
        playerState = AudioPlayerState.STOPPED;
      });
    } catch (e) {
      print("Error onComplete(): $e");
    }
  }

  void fastForward() {
    try {
      Duration forward = position + new Duration(seconds: 15);

      if (forward < duration) {
        audioPlayer.seek(forward);
      } else {
        audioPlayer.stop();
        playerState = AudioPlayerState.STOPPED;
      }
    } catch (e) {
      print("Error fastForward(): $e");
    }
  }

  void fastRewind() {
    try {
      Duration rewind = position - new Duration(seconds: 15);
      Duration t0 = new Duration();

      if (rewind > t0) {
        audioPlayer.seek(rewind);
      } else {
        audioPlayer.seek(t0);
      }
    } catch (e) {
      print("Error fastRewind(): $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
       children: [_buildPlayerControllsWidget(context),]
      )
    );
  }

  Widget _buildPlayerControllsWidget(BuildContext context) {
    return new Container(
        color: Colors.black87,
        padding: new EdgeInsets.all(16.0),
        child: new Column(mainAxisSize: MainAxisSize.max, children: [
          new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Slider(
                  activeColor: Colors.red,
                  value: position?.inMilliseconds?.toDouble() ?? 0.0,
                  onChanged: (double value) => audioPlayer.seek(Duration(milliseconds: value.toInt())),
                  min: 0.0,
                  max: duration?.inMilliseconds?.toDouble() ?? 0.0,
                ),
                new Text("$positionText / $durationText",
                    style: new TextStyle(fontSize: 16.0, color: Colors.white))
              ]),
          new Row(mainAxisSize: MainAxisSize.min, children: [
            new IconButton(
                onPressed: isPlaying ? () => fastRewind() : null,
                iconSize: 32.0,
                icon: new Icon(
                  Icons.fast_rewind,
                  semanticLabel: "15",
                ),
                color: Colors.cyan),
            _playOrPauseSwitchWidget(context), // switch play pause
            new IconButton(
                onPressed: isPlaying ? () => fastForward() : null,
                iconSize: 32.0,
                icon: new Icon(
                  Icons.fast_forward,
                  semanticLabel: "15",
                ),
                color: Colors.cyan),
          ]),
        ]));
  }

  /// Switch between play and pause buttons
  Widget _playOrPauseSwitchWidget(BuildContext context) {
    if (playerState != AudioPlayerState.PLAYING) {
      return new IconButton(
          onPressed: isPlaying ? null : () => play(context),
          iconSize: 32.0,
          icon: new Icon(Icons.play_arrow),
          color: Colors.white);
    }

    return new IconButton(
        onPressed: isPlaying ? () => pause() : null,
        iconSize: 32.0,
        icon: new Icon(Icons.pause),
        color: Colors.white);
  }

  /// Subscribe to [playState and position]
  subscribeToPositionAndDurationEvent() {
    try {
      _positionSubscription = audioPlayer.onAudioPositionChanged.listen((p) {
        setState(() => position = p);
      });
      _audioPlayerStateSubscription =
          audioPlayer.onPlayerStateChanged.listen((s) {
        audioPlayer.onDurationChanged.listen((Duration d) {
          setState(() => duration = d);
        });
        audioPlayer.onPlayerCompletion.listen((event) {
          onComplete();
        });
      }, onError: (msg) {
        setState(() {
          playerState = AudioPlayerState.STOPPED;
          duration = new Duration(seconds: 0);
          position = new Duration(seconds: 0);
        });
      });
    } catch (e) {
      print("Error subscribeToPositionAndDurationEvent(): $e");
    }
  }

  showSnakBar(BuildContext context, final message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
