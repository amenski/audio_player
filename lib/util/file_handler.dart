import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter_audio_palyer/util/util.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';

class FileHandler {
  Util util = Util();

 
Future<io.File> _writeFileToDisk(io.File file) async {
  try {
    var dir = await getExternalStorageDirectory();
    var appdir = await new io.Directory('${dir.path}/audio_player').create(recursive: true);
    if(appdir != null){
      //TODO add implementation
    }

  } catch (e) {
    print(e);
    return null;
  }
}



/// 
static final _instance = FileHandler._internal();
factory FileHandler() => _instance;
FileHandler._internal();

}