import 'package:image_picker/image_picker.dart';

class ImageLoader {
  final picker = ImagePicker();

  Future<String> getImageCamera(int quality) async {
    return getImage(ImageSource.camera,quality);
  }

  Future<String> getImageGallery(int quality) async {
    return getImage(ImageSource.gallery,quality);
  }

  Future<String> getImage(source,int quality) async {
    final pickedFile = await picker.getImage(source: source,imageQuality: quality);

    if (pickedFile != null) {
      print(pickedFile.path);
      return pickedFile.path;
    } else {
      print('No image selected.');
      return null;
    }
  }
}
