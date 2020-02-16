import 'package:permission_handler/permission_handler.dart';

class PermissionService  {
  /// Get `WriteExternalStorage` permission status, or request if not granted
 Future<bool> get getPermissionWriteExternal async {
    bool permissionStatus = await checkPermission(PermissionGroup.storage);
    if(!permissionStatus){
      permissionStatus = await requestPermission(PermissionGroup.storage);
    }

    return permissionStatus;
  }

  Future<bool> checkPermission(PermissionGroup permission) async {
    PermissionStatus status = await PermissionHandler().checkPermissionStatus(permission);

    return status == PermissionStatus.granted;
  }

  Future<bool> requestPermission(PermissionGroup permission) async {
      // bool isShown = await PermissionHandler().shouldShowRequestPermissionRationale(permission);
      Map<PermissionGroup, PermissionStatus> result = await PermissionHandler().requestPermissions([permission]);
      
      if (result[permission] == PermissionStatus.granted)
        return true;

      // TODO openAppSettings()? 

      return false;
  }
}