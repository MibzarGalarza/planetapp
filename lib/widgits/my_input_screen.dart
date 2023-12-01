import 'package:flutter/material.dart';
import 'package:planetapp/widgits/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:planetapp/modules/classes.dart' as app_classes;

class MyInputScreen extends StatefulWidget {
  static const routeName = 'MyInputScreen';
  @override
  _MyInputScreenState createState() => _MyInputScreenState();
}

class _MyInputScreenState extends State<MyInputScreen> {
  final _titleController = TextEditingController();
  final _sizeController = TextEditingController();
  final _desController = TextEditingController();
  final _distanceController = TextEditingController();

  late File savedImage;

  String _selectedType = 'Sistema';
  String _natureType = 'Gas';

  List<String> _typeOptions = [
    'Sistema',
    'Estrella',
    'Planeta',
    'Asteroide',
    'Cometa',
    'Sin Identificar'
  ];
  List<String> _naturetypeOptions = [
    'Gas',
    'Liquido',
    'Solido o Rocoso',
  ];

  Map<String, String> _typeImages = {
    'Sistema':
        'https://images.milenio.com/oSQUd7oYNqsT5Au_IanZYgoVJCQ=/942x532/uploads/media/2020/05/01/urano-centro-sistema-solar-sol.jpg',
    'Estrella':
        'https://upload.wikimedia.org/wikipedia/commons/6/62/Starsinthesky.jpg',
    'Planeta':
        'https://upload.wikimedia.org/wikipedia/commons/c/cf/Planet_collage_to_scale.jpg',
    'Asteroide':
        'https://s2.glbimg.com/pc0uEdIwajEiQKBKyXO-3gIEdg8=/620x465/s.glbimg.com/jo/g1/f/original/2016/08/27/asteroide_MXwAq9e.jpg',
    'Cometa':
        'https://concepto.de/wp-content/uploads/2019/06/cometa-e1561938278988.jpg',
    'Sin Identificar':
        'https://previews.123rf.com/images/ekaart/ekaart1602/ekaart160200398/52365047-conjunto-de-3-pregunta-s%C3%ADmbolo-original-pintado-a-mano-mano-icono-de-signo-de-interrogaci%C3%B3n.jpg',
  };

  Map<String, String> _naturetypeImages = {
    'Gas':
        'https://astrosigma.com/images/sistema-solar/gigantes-gaseosos-600.jpg',
    'Liquido':
        'https://cdn.businessinsider.es/sites/navi.axelspringer.es/public/media/image/2022/06/agua-liquida-planetas-2743267.jpg?tf=1200x',
    'Solido o Rocoso':
        'https://upload.wikimedia.org/wikipedia/commons/b/b9/Terrestrial_planet_size_comparisons.jpg',
  };

  void savedImages(File image) {
    savedImage = image;
  }

  void onSave() {
    if (_titleController.text.isEmpty ||
        _sizeController.text.isEmpty ||
        _desController.text.isEmpty ||
        _distanceController.text.isEmpty ||
        _selectedType.isEmpty ||
        _natureType.isEmpty ||
        // ignore: unnecessary_null_comparison
        savedImage == null) {
      return;
    } else {
      Provider.of<app_classes.ImageFile>(context, listen: false).addImagesPlace(
          _titleController.text,
          _selectedType,
          _natureType,
          _distanceController.text,
          _sizeController.text,
          _desController.text,
          savedImage);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' '),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: onSave),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _desController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(
              height: 30,
            ),
            DropdownButton<String>(
              value: _selectedType,
              items: _typeOptions.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Image.network(
                          _typeImages[
                              type]!, // Suponiendo que 'type' es el tipo seleccionado
                          width: 90,
                          height: 40,
                        ),
                        SizedBox(
                          height: 45,
                          width: 100,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(type),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue!;
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            DropdownButton<String>(
              value: _natureType,
              items: _naturetypeOptions.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Image.network(
                          _naturetypeImages[
                              type]!, // Suponiendo que 'type' es el tipo seleccionado
                          width: 90,
                          height: 40,
                        ),
                        SizedBox(
                          height: 45,
                          width: 100,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(type),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _natureType = newValue!;
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _sizeController,
              decoration: InputDecoration(labelText: 'Size in KM'),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _distanceController,
              decoration: InputDecoration(
                  labelText: 'Distance with respect to planet Earth.'),
            ),
            SizedBox(
              height: 30,
            ),
            ImageInput(savedImages),
          ]),
        ),
      ),
    );
  }
}
