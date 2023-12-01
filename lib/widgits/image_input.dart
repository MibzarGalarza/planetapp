import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function imagesaveat;
  ImageInput(this.imagesaveat);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  late File _imageFile;

  @override
  void initState() {
    super.initState();
    _imageFile = File(
        ''); // Puedes inicializar con un valor predeterminado, como un archivo vacío.
  }

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 600);

    if (imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });

    final apDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImagePath = await _imageFile.copy('${apDir.path}/$fileName');

    widget.imagesaveat(saveImagePath);
  }

  Future<void> _galleryPicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.getImage(source: ImageSource.gallery, maxWidth: 600);

    if (imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });

    final apDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImagePath = await _imageFile.copy('${apDir.path}/$fileName');

    widget.imagesaveat(saveImagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.deepOrange),
          ),
          // ignore: unnecessary_null_comparison
          child: _imageFile != null
              ? Image.file(
                  _imageFile,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Text('No Image Yet, add image'),
                ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _galleryPicture,
              icon: Icon(Icons.image),
              label: Text('Add your Image'),
            ),
            TextButton.icon(
              onPressed: _takePicture,
              icon: Icon(Icons.camera),
              label: Text('Take Picture'),
            ),
          ],
        ),
      ],
    );
  }
}
