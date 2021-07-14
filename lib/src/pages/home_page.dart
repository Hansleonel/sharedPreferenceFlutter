import 'package:flutter/material.dart';
import 'package:sharedpreferencesapp/src/utils/preferencias_usuario.dart';
import 'package:sharedpreferencesapp/src/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {
  // nombre de la ruta almacenada dentro de una variable static final
  // con el nombre de "routeName" para manejar las rutas dentro de nuestro Widget Principal Main()
  static final String routeName = 'home';

  // usando la misma instanciacion que se uso en nuestro metodo principal main() gracias al uso del factory dentro de nuestra class
  // PreferenciasUsuario{}
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefs.setPageUser = HomePage.routeName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        // usando el valor almacenado dentro de nuestro SharedPreference para poder establecer el color del AppBar
        // con la siguiente condicion
        backgroundColor: (prefs.getSecondaryColor) ? Colors.teal : Colors.blue,
      ),
      drawer: DrawerWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Secondary Color: ${prefs.getSecondaryColor}'),
          Divider(),
          Text('Gender: ${prefs.getGenero}'),
          Divider(),
          Text('User Name ${prefs.getName}'),
          Divider()
        ],
      ),
    );
  }
}
