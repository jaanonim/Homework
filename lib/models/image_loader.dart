import 'package:image_picker/image_picker.dart';

class ImageLoader {
  final picker = ImagePicker();

  Future<String> getImageCamera() async {
    return getImage(ImageSource.camera);
  }

  Future<String> getImageGallery() async {
    return getImage(ImageSource.gallery);
  }

  Future<String> getImage(source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      print('No image selected.');
      return null;
    }
  }
}
