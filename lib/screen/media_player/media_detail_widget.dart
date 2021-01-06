import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:audiobook/util/util.dart';
import 'package:audiobook/model/post.dart';
import 'package:audiobook/util/constants.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audiobook/util/file_handler.dart';
import 'package:audiobook/util/network_operations.dart';
import 'package:audiobook/widgets/image_banner/image_banner.dart';
import 'package:audiobook/repository/media_player_repository.dart';

class MediaDetailWidget extends StatefulWidget {
  final Post post;

  MediaDetailWidget(this.post); // will mainly be instantiated from the route logic

  @override
  _MediaDetailWidgetState createState() => new _MediaDetailWidgetState(post);
}

class _MediaDetailWidgetState extends State<MediaDetailWidget> {
  Post _post;

  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  String localFilePath;
  MediaPlayerRepository repository = new MediaPlayerRepository();

  AudioPlayerState playerState = AudioPlayerState.STOPPED;

  get isPlaying => playerState == AudioPlayerState.PLAYING;
  get isPaused => playerState == AudioPlayerState.PAUSED;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  Util util = Util();
  FileHandler fileHandler = FileHandler();
  NetworkOperations networkOperations = NetworkOperations();

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
    try {
      //AudioPlayer.logEnabled = true;
      audioPlayer = new AudioPlayer();
      subscribeToPositionAndDurationEvent();
    } catch(e){
      log(e);
    }
  }

  /// Play from local_file if already downloaded or else from url provided
  Future play(GlobalKey<ScaffoldState> state) async {
    final connected = await networkOperations.isConnectedToInternet();
    if(!connected) {
      showSnakBar(state, Constants.NO_INTERNET_CONNECTION_ERROR);
      return;
    }

    //seek back to start
    if (position == duration) {
      position = new Duration(seconds: 0);
    }
    await audioPlayer.play(_post.url, isLocal: _post.isDownloaded);
    // state.currentState.showSnackBar(
    //     new SnackBar(duration: new Duration(seconds: 100), content:
    //     new Row(
    //       children: <Widget>[
    //         new CircularProgressIndicator(),
    //         new Text("    Loading ...")
    //       ],
    //     ),
    //     ),
    //   );
    setState(() {
      playerState = AudioPlayerState.PLAYING;
    });
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = AudioPlayerState.PAUSED);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      position = new Duration();
      playerState = AudioPlayerState.STOPPED;
    });
  }

  void onComplete() {
    // mark as opened
    repository.updatePostOpened(_post.id, _post.categoryId);

    setState(() {
      position = new Duration();
      playerState = AudioPlayerState.STOPPED;
    });
  }

  void fastForward() {
    Duration forward = position + new Duration(seconds: 15);
    
    if(forward < duration) {
      audioPlayer.seek(forward);
    } else {
      audioPlayer.stop();
      playerState = AudioPlayerState.STOPPED;
    }
  }

  void fastRewind() {
    Duration rewind = position - new Duration(seconds: 15);
    Duration t0 = new Duration();

    if(rewind > t0) {
      audioPlayer.seek(rewind);
    } else {
      audioPlayer.seek(t0);
    }
  }
  // TODO next release
  Future _downloadMediaFile(GlobalKey<ScaffoldState> state) async {
    try {
      //bool permissionGranted = await PermissionService().getPermissionWriteExternal;
      bool permissionGranted = true;
      if (!this._post.isDownloaded && permissionGranted) {
        Uint8List bytesList = await networkOperations.getFileFromNetwork(this._post.url);
        File file = await fileHandler.writeFileToDisk(bytesList, name: util.generateMediaFileName([this._post.description, this._post.title]));
        if (file != null && await file.exists()) {
          setState(() {
            localFilePath = file.path;
            this._post.url = localFilePath;
            this._post.isDownloaded = true;
          });
        }
      } else {
        // Widget message = Text(Constants.STORAGE_PERMISSION_DENIED_ERROR);
        Widget message = Text(Constants.FEATURE_NOT_AVAILABLE);
        if (this._post.isDownloaded) {
          message = Text(Constants.MEDIA_ALREADY_DOWNLOADED);
          localFilePath = this._post.url;
        }
        showSnakBar(state, message);
      }
    } catch(e) {
      log(e, level: 0);
    }

  }

  @override
  Widget build(BuildContext context) {
     final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(this._post.title),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: Icon(Icons.file_download),
                  onPressed: () => _downloadMediaFile(_scaffoldKey),
                );
              },
            ),

          // IconButton(
          //   icon: Icon(Icons.share),
          //   onPressed: () => print("On share."),
          // ),
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
                  Text(this._post.title),
                  Text(this._post.description ?? ""),
                  new Material(child: _buildPlayer(this._post.thumbUrl, _scaffoldKey)),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayer(String url, GlobalKey<ScaffoldState> scaffoldKey) => new SingleChildScrollView(
      child: Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(mainAxisSize: MainAxisSize.min, children: [
            new Container(
              constraints: BoxConstraints.expand(height: 200),
              child: ImageBanner(url: url,),
            ),
            Text(localFilePath ?? ''),
            new Row(mainAxisSize: MainAxisSize.min, children: [
              new IconButton(
                  onPressed: isPlaying ? () => fastRewind() : null,
                  iconSize: 64.0,
                  icon: new Icon(Icons.fast_rewind, semanticLabel: "15",),
                  color: Colors.cyan),
              _playOrPauseSwitch(scaffoldKey), // switch play pause
              new IconButton(
                  onPressed: isPlaying ? () => fastForward() : null,
                  iconSize: 64.0,
                  icon: new Icon(Icons.fast_forward, semanticLabel: "15",),
                  color: Colors.cyan),
            ]),
            duration == null
                ? new Container() // display nothing
                : new Column(children: <Widget>[
                    Slider(
                      value: position?.inMilliseconds?.toDouble() ?? 0.0,
                      onChanged: (double value) => audioPlayer.seek(Duration(milliseconds: value.toInt())),
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

  showSnakBar(GlobalKey<ScaffoldState> state, final message) {
    final snackBar = SnackBar(content: Text(message));
    state.currentState.showSnackBar(snackBar); //TODO instead of globalKey, use separate_widget or builder_widget
  }

  /// Subscribe to [playState and position]
  subscribeToPositionAndDurationEvent() {
    _positionSubscription = audioPlayer.onAudioPositionChanged.listen((p) { 
      setState(() => position = p);
    });
    _audioPlayerStateSubscription = audioPlayer.onPlayerStateChanged.listen((s) {
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
  }

  /// Switch between play and pause buttons
  Widget _playOrPauseSwitch(GlobalKey<ScaffoldState> scaffoldKey) {
    if(playerState != AudioPlayerState.PLAYING) {
      return new IconButton(
                  onPressed: isPlaying ? null : () => play(scaffoldKey),
                  iconSize: 64.0,
                  icon: new Icon(Icons.play_arrow),
                  color: Colors.cyan);
    }

    return new IconButton(
                  onPressed: isPlaying ? () => pause() : null,
                  iconSize: 64.0,
                  icon: new Icon(Icons.pause),
                  color: Colors.cyan);
  }
}
