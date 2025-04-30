import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io' show Platform;

class AppInfo {
  final String packageName;
  final String appName;
  final String versionName;
  final String buildNumber;

  AppInfo({
    required this.packageName,
    required this.appName,
    required this.versionName,
    required this.buildNumber,
  });
}

class AppPermissions {
  /// Request notification permission
  static Future<bool> requestNotificationPermission() async {
    if (await Permission.notification.isGranted) {
      return true;
    }
    
    // Request notification permission
    final status = await Permission.notification.request();
    
    // Show a dialog explaining why we need notification permission
    if (status.isDenied) {
      // You can show a custom dialog here explaining why notifications are needed
      return false;
    }
    
    return status.isGranted;
  }

  /// Request storage permissions including MANAGE_EXTERNAL_STORAGE for Android 11+
  static Future<bool> requestStoragePermissions() async {
    if (await Permission.storage.isGranted) {
      return true;
    }

    // Request basic storage permissions first
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    // Check if basic storage permission is granted
    if (statuses[Permission.storage]!.isGranted) {
      // For Android 11+, we need to request MANAGE_EXTERNAL_STORAGE
      if (await Permission.manageExternalStorage.isDenied) {
        return await Permission.manageExternalStorage.request().isGranted;
      }
      return true;
    }
    return false;
  }

  /// Request permission to read phone state (for device info)
  static Future<bool> requestPhoneStatePermission() async {
    if (await Permission.phone.isGranted) {
      return true;
    }
    return (await Permission.phone.request()).isGranted;
  }

  /// Get current application information
  static Future<AppInfo> getCurrentAppInfo() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return AppInfo(
        packageName: packageInfo.packageName,
        appName: packageInfo.appName,
        versionName: packageInfo.version,
        buildNumber: packageInfo.buildNumber,
      );
    } catch (e) {
      print('Error getting package info: $e');
      return AppInfo(
        packageName: '',
        appName: '',
        versionName: '',
        buildNumber: '',
      );
    }
  }

  /// Get device information
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    Map<String, dynamic> deviceData = {};

    try {
      if (await Permission.phone.isGranted) {
        if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          deviceData = {
            'model': androidInfo.model,
            'manufacturer': androidInfo.manufacturer,
            'version': androidInfo.version.release,
            'sdkVersion': androidInfo.version.sdkInt,
            'device': androidInfo.device,
            'board': androidInfo.board,
            'hardware': androidInfo.hardware,
            'brand': androidInfo.brand,
            'display': androidInfo.display,
            'host': androidInfo.host,
            'id': androidInfo.id,
            'product': androidInfo.product,
            'tags': androidInfo.tags,
            'type': androidInfo.type,
            'isPhysicalDevice': androidInfo.isPhysicalDevice,
            'systemFeatures': androidInfo.systemFeatures,
          };
        } else if (Platform.isIOS) {
          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          deviceData = {
            'name': iosInfo.name,
            'systemName': iosInfo.systemName,
            'systemVersion': iosInfo.systemVersion,
            'model': iosInfo.model,
            'localizedModel': iosInfo.localizedModel,
            'identifierForVendor': iosInfo.identifierForVendor,
            'isPhysicalDevice': iosInfo.isPhysicalDevice,
            'utsname': {
              'sysname': iosInfo.utsname.sysname,
              'nodename': iosInfo.utsname.nodename,
              'release': iosInfo.utsname.release,
              'version': iosInfo.utsname.version,
              'machine': iosInfo.utsname.machine,
            },
          };
        }
      }
    } catch (e) {
      print('Error getting device info: $e');
    }

    return deviceData;
  }
} 