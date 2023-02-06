// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:image/image.dart' as imglib;

class ApiManager {
  static Future<List<int>?> convertYUV420toImageColor(CameraImage image) async {
    try {
      final int width = image.width;
      final int height = image.height;

      // imglib -> Image package from https://pub.dartlang.org/packages/image
      var img = imglib.Image(width, height); // Create Image buffer

      Plane plane = image.planes[0];
      const int shift = (0xFF << 24);

      // Fill image buffer with plane[0] from YUV420_888
      for (int x = 0; x < width; x++) {
        for (int planeOffset = 0;
            planeOffset < height * width;
            planeOffset += width) {
          final pixelColor = plane.bytes[planeOffset + x];
          // color: 0x FF  FF  FF  FF
          //           A   B   G   R
          // Calculate pixel color
          var newVal =
              shift | (pixelColor << 16) | (pixelColor << 8) | pixelColor;
          img.data[planeOffset + x] = newVal;
        }
      }

      imglib.PngEncoder pngEncoder = imglib.PngEncoder(level: 0, filter: 0);
      // Convert to png
      List<int> png = pngEncoder.encodeImage(img);
      return png;
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:$e");
    }
    return null;
  }

  static Future<http.ByteStream?> uploadVideoAsFormData(
      String url, CameraImage image) async {
    try {
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath(
          'video', convertYUV420toImageColor(image).toString()));

      var res = await request.send();
      if (res.statusCode == 200) {
        return res.stream;
      } else {
        return res.stream;
      }
    } catch (err) {
      return null;
    }
  }
}
