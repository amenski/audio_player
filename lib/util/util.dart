import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';

typedef OnError = void Function(Exception exception);

typedef OnCardTap = void Function(BuildContext context, int id);

class Util {

 /// Get `WriteExternalStorage` permission status, or request if not granted
 Future<bool> get getPermissionWriteExternal async {
    bool permissionStatus = await checkPermission(Permission.WriteExternalStorage);
    if(!permissionStatus){
      permissionStatus = await requestPermission(Permission.WriteExternalStorage);
    }

    return permissionStatus;
  }

  Future<bool> checkPermission(Permission permission) async {
    bool checkResult = await SimplePermissions.checkPermission(permission);
    if(!checkResult)
      requestPermission(permission);

    return false;
  }

  Future<bool> requestPermission(Permission permission) async {
      var status = await SimplePermissions.requestPermission(permission);
      
      if (status == PermissionStatus.authorized)
        return true;

      return false;
  }


  Future<Uint8List> getImageFromNetwork(String url) async {
    final bytes = await loadFromUrl(url,
        onError: (Exception exception) =>
            print('getImageFromNetwork => exception $exception'));

    return bytes;
  }
  
  /// Load a file from `url`
  Future<Uint8List> loadFromUrl(String url, {OnError onError}) async {
    Uint8List bytes;
    try {
      bytes = await readBytes(url);
    } on Exception {
      rethrow;
    }
    return bytes;
  }

  /// Util instantiation
  static Util _instance = Util._internal();
  factory Util() => _instance;
  Util._internal();
}
