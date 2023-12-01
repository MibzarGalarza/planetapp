import 'package:flutter/material.dart';
import 'package:planetapp/widgits/my_input_screen.dart';
import 'package:planetapp/modules/classes.dart' as ima;
import 'package:provider/provider.dart';
import 'details_screen.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7EFD8),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MyInputScreen.routeName);
        },
        child: Icon(Icons.image),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF7EFD8),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Planets',
              style: TextStyle(
                color: Color.fromRGBO(75, 66, 52, 1.0),
                fontWeight: FontWeight.bold,
                fontSize: 35.0,
              ),
            ),
            Text(
              'System Solar',
              style: TextStyle(
                color: Color.fromRGBO(75, 66, 52, 1.0),
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              margin: EdgeInsets.only(
                  right: 16.0), // Ajusta el margen si es necesario
              child: IconButton(
                color: Color.fromRGBO(188, 180, 157, 1.0),
                icon: Icon(Icons.search),
                iconSize: 30.0, // Tamaño del icono
                onPressed: () {
                  // Manejar la acción de búsqueda aquí
                },
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color.fromRGBO(188, 180, 157, 1.0),
                  width: 2.0, // Ancho del contorno
                ),
              ),
            ),
          ),
        ],
        toolbarHeight: 100.0,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: Provider.of<ima.ImageFile>(context, listen: false).fatchImage(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<ima.ImageFile>(
                child: Center(child: Text('Start adding your planets')),
                builder: (ctx, image, ch) {
                  if (image.items.length <= 0) {
                    return ch ?? Container();
                  } else {
                    return Column(
                      children: [
                        // Imágenes Rectangulares
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: image.items.map((item) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      DetailesScreen.routeName,
                                      arguments: item.id,
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: 250,
                                      height: 450,
                                      child: Image.file(
                                        item.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        // Imágenes Circulares y Títulos
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: image.items.map((item) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      DetailesScreen.routeName,
                                      arguments: item.id,
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 70,
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                          child: Image.file(
                                            item.image,
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 150,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        item.title,
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(75, 66, 52, 1.0),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
      ),
    );
  }
}
