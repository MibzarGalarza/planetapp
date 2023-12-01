import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'database.dart';

class Image {
  final String id;
  final String title;
  final String selectedType;
  final String natureType;
  final String distance;
  final String size;
  final String des;
  final File image;

  Image({
    required this.image,
    required this.title,
    required this.selectedType,
    required this.natureType,
    required this.distance,
    required this.id,
    required this.size,
    required this.des,
  });
}

class ImageFile with ChangeNotifier {
  List<Image> _items = [];
  List<Image> get items {
    return [..._items];
  }

  Future<void> addImagesPlace(
      String title,
      String selectedType,
      String natureType,
      String distance,
      String des,
      String size,
      File image) async {
    final newImage = Image(
      image: image,
      title: title,
      id: DateTime.now().toString(),
      size: size,
      des: des,
      distance: distance,
      selectedType: selectedType,
      natureType: natureType,
    );
    _items.add(newImage);
    notifyListeners();

    DataHelper.insert('user_image', {
      'id': newImage.id,
      'size': newImage.size,
      'des': newImage.des,
      'image': newImage.image.path,
      'title': newImage.title,
      'selectedType': newImage.selectedType,
      'natureType': newImage.natureType,
      'distance': newImage.distance,
    });
  }

  Image findImage(String imageId) {
    return _items.firstWhere((image) => image.id == imageId);
  }

  Future<void> fatchImage() async {
    final list = await DataHelper.getData('user_image');
    _items = list
        .map(
          (item) => Image(
            image: File(item['image']),
            title: item['title'],
            distance: item['distance'],
            id: item['id'],
            des: item['des'],
            size: item['size'],
            selectedType: item['selectedType'],
            natureType: item['natureType'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
