import 'package:flutter/material.dart';
import 'package:sharedpreferencesapp/src/pages/home_page.dart';
import 'package:sharedpreferencesapp/src/pages/settings_page.dart';
import 'package:sharedpreferencesapp/src/utils/preferencias_usuario.dart';

void main() async {
  // en caso usemos algun metodo que afecte o atrace la inicializacion del arbol de Widgets
  // debemos de usar la sigueinte linea
  WidgetsFlutterBinding.ensureInitialized();
  // inincializacion nuestra instancia de nuestro SharedPreferences en este punto
  // puesto que de esta forma podemos usar los valores de nuestro SharedPrefences incluso en StatelessWidgets
  // puesto que ya tendriamos los valores cargados
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // usando la misma instancia de la parte superior ya que dentro de nuestro singleton usamos factory como tipo de constructor
  // es decir siempre usermos esa unica instancia
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences',
      // usamos el singleton y sus getters en este caso el get "getPageUser" que como sabemos es tratada como propiedad y no como metodo
      // para obtener la ruta inicial desde el SharedPreference
      initialRoute: prefs.getPageUser,
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        SettingsPage.routeName: (BuildContext context) => SettingsPage()
      },
    );
  }
}
