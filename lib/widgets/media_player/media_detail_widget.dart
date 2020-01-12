import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_audio_palyer/model/post.dart';

import '../../util/util.dart';

const kUrl = "http://debelo.org/debelo_mvc/Audio/Mezemure%20dawit/00.mp3";
const kUrl2 = "http://debelo.org/debelo_mvc/Audio/_LitonZesebatuEletat/ZeselusSimikeHiyaw.mp3";
const imageUrl = 'http://debelo.org/debelo_mvc/Content/images/category/debeloMain.jpg';

enum PlayerState { stopped, playing, paused }

class MediaDetailWidget extends StatefulWidget {
  final Post post;

  MediaDetailWidget(this.post); // will mainly be instantiated from the route logic

  @override
  _MediaDetailWidgetState createState() => new _MediaDetailWidgetState(post);
}
/// TODO use data coming from HomePage, i.e `_url`
class _MediaDetailWidgetState extends State<MediaDetailWidget> {
  Post _post;

  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  Util util = Util();

  _MediaDetailWidgetState(this._post);

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
    audioPlayer = new AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        audioPlayer.onDurationChanged.listen((Duration d) {
          setState(() => duration = d);
        });
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
        });
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });
  }

  /// Play from local_file if already downloaded or else from url provided
  Future play() async {
    if (position == duration) {
      position = new Duration(seconds: 0);
    }
    await audioPlayer.play(_post.getUrl, isLocal: _post.isDownloaded);
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = new Duration();
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  Future _loadFile() async {
    print("downloading file...");
    File file = await util.downloadFromUrl(kUrl);
    if (await file.exists())
      setState(() {
        localFilePath = file.path;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Player"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => _loadFile(),
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => print("On share."),
          ),
        ],
      ),
      body: Center(
        child: new Material(
          elevation: 2.0,
          color: Colors.grey[200],
          child: new Center(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  new Material(child: _buildPlayer()),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayer() => new SingleChildScrollView(
      child: Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(mainAxisSize: MainAxisSize.min, children: [
            new Container(
              constraints: BoxConstraints.expand(height: 200),
              child: Image.network(imageUrl),
            ),
            Text(localFilePath ?? ''),
            new Row(mainAxisSize: MainAxisSize.min, children: [
              new IconButton(
                  onPressed: isPlaying ? null : () => play(),
                  iconSize: 64.0,
                  icon: new Icon(Icons.play_arrow),
                  color: Colors.cyan),
              new IconButton(
                  onPressed: isPlaying ? () => pause() : null,
                  iconSize: 64.0,
                  icon: new Icon(Icons.pause),
                  color: Colors.cyan),
              new IconButton(
                  onPressed: isPlaying || isPaused ? () => stop() : null,
                  iconSize: 64.0,
                  icon: new Icon(Icons.stop),
                  color: Colors.cyan),
            ]),
            duration == null
                ? new Container()
                : new Column(children: <Widget>[
                    Slider(
                      value: position?.inMilliseconds?.toDouble() ?? 0.0,
                      onChanged: (double value) => audioPlayer
                          .seek(Duration(milliseconds: value.toInt())),
                      min: 0.0,
                      max: duration.inMilliseconds.toDouble(),
                    ),
                    new Text(
                        position != null
                            ? "${positionText ?? ''} / ${durationText ?? ''}"
                            : duration != null ? durationText : '',
                        style: new TextStyle(fontSize: 24.0))
                  ])
          ])));
}
