import 'dart:io' as io;
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_audio_palyer/util/permission_service.dart';
import 'package:flutter_audio_palyer/util/util.dart';
import 'package:path_provider/path_provider.dart';

/// This recipe uses the following steps:
    /// 1. Find the correct local path.
    /// 2. Create a reference to the file location.
    /// 3. Write data to the file.
    /// 4. Read data from the file.

class FileHandler {
  Util util = Util();

Future<String> _localPath() async {
  var dir;
  bool permission = await PermissionService().getPermissionWriteExternal;
  if(permission) {
   dir = await getExternalStorageDirectory();
   await new io.Directory('${dir.path}/media')
                  .create(recursive: true)
                  .then((d) => dir = d)
                  .catchError(print);
  } else {
    dir = await getApplicationDocumentsDirectory();
  }
  return dir.path;
}

/// Accepts bytes (Uint8List = byte list) and saves to file
Future<io.File> writeFileToDisk(Uint8List bytes, {String name = 'audio'}) async {
  File file;
  try {
    var dir = await _localPath();
    if(dir != null){
      file = new io.File('$dir/$name.mp3');
      file.writeAsBytes(bytes, flush: true);
    }
  } catch (e) {
    print(e);
  }
  
  return file;
}

/// 
static final _instance = FileHandler._internal();
factory FileHandler() => _instance;
FileHandler._internal();

}