import 'package:flutter/material.dart';
import 'package:planetapp/modules/classes.dart' as ima;
import 'package:provider/provider.dart';
import 'package:planetapp/widgits/my_input_screen.dart';

class DetailesScreen extends StatefulWidget {
  static const routeName = 'DetailesScreen';

  @override
  _DetailesScreenState createState() => _DetailesScreenState();
}

class _DetailesScreenState extends State<DetailesScreen> {
  final List<String> options = ['Descripcion', 'Distance', 'Map'];
  int selectedOptionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final imageId = ModalRoute.of(context)?.settings.arguments as String;
    final image =
        Provider.of<ima.ImageFile>(context, listen: false).findImage(imageId);

    final backgroundColor = Color(0xFFF7EFD8);
    final textColor = Color.fromRGBO(75, 66, 52, 1.0);
    final iconColor = Color.fromRGBO(75, 66, 52, 1.0);
    final selectedColor = Color(0xFFEEE1BB);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        toolbarHeight: 70.0,
        iconTheme: IconThemeData(
          color: iconColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 20.0,
                  left: 17,
                  right: 17,
                  bottom: 20,
                ),
                height: 400,
                width: double.infinity,
                child: ClipOval(
                  child: Image.file(
                    image.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: backgroundColor,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 40.0,
                    ),
                    child: Text(
                      image.title,
                      style: TextStyle(
                        fontSize: 35,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    color: backgroundColor,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 40.0),
                        child: Text(
                          image.natureType,
                          style: TextStyle(
                            fontSize: 20,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: backgroundColor,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 90.0),
                        child: Text(
                          image.des,
                          style: TextStyle(
                            fontSize: 20,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: backgroundColor,
                child: Text(
                  image.selectedType,
                  style: TextStyle(
                    fontSize: 30,
                    color: textColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  for (int i = 0; i < options.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOptionIndex = i;
                        });
                      },
                      child: Container(
                        color: backgroundColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          options[i],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: i == selectedOptionIndex
                                ? selectedColor
                                : textColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: selectedOptionIndex == 0,
                child: Container(
                  color: backgroundColor,
                  child: Text(
                    image.size,
                    style: TextStyle(
                      fontSize: 30,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: selectedOptionIndex == 1,
                child: Container(
                  color: backgroundColor,
                  child: Text(
                    image.distance,
                    style: TextStyle(
                      fontSize: 30,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(75, 66, 52, 1.0), // Color de la sombra
              spreadRadius: 2, // La expansión de la sombra
              blurRadius: 2, // La desenfoque de la sombra
              offset: Offset(
                  0, 3), // La posición de la sombra (en este caso, abajo)
            ),
          ],
        ),
        height: 80, // Ajusta el tamaño según tus necesidades
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.blur_circular),
              color: Color.fromRGBO(75, 66, 52, 1.0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.image_aspect_ratio_outlined),
              color: Color.fromRGBO(75, 66, 52, 1.0),
              onPressed: () {
                Navigator.pushNamed(context, MyInputScreen.routeName);
              },
            ),
            IconButton(
              icon: Icon(Icons.map_outlined),
              color: Color.fromRGBO(75, 66, 52, 1.0),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
