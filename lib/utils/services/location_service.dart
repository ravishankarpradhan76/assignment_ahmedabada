import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Request location permission with business logic
  static Future<bool> requestPermission() async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      final result = await Permission.location.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      // Open settings when permanently denied
      await openAppSettings();
      return false;
    }
    return false;
  }

  /// Get current position safely
  static Future<Position?> getCurrentPosition() async {
    final granted = await requestPermission();
    if (!granted) return null;

    if (!await Geolocator.isLocationServiceEnabled()) {
      await Geolocator.openLocationSettings();
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
