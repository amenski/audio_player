import 'package:permission_handler/permission_handler.dart';

class PermissionService  {
  /// Get `WriteExternalStorage` permission status, or request if not granted
 Future<bool> get getPermissionWriteExternal async {
    bool permissionStatus = await checkPermission(Permission.storage);
    if(!permissionStatus){
      permissionStatus = await requestPermission(Permission.storage);
    }

    return permissionStatus;
  }

  Future<bool> checkPermission(Permission permission) async {
    PermissionStatus status = await permission.status;

    return status == PermissionStatus.granted;
  }

  Future<bool> requestPermission(Permission permission) async {
      // bool isShown = await PermissionHandler().shouldShowRequestPermissionRationale(permission);
      // Map<Permission, PermissionStatus> result = await PermissionHandler().requestPermissions([permission]);
      
      // if (result[permission] == PermissionStatus.granted)
      //   return true;

      // TODO openAppSettings()? 

      return false;
  }
}