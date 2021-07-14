import 'package:flutter/material.dart';
import 'package:sharedpreferencesapp/src/pages/home_page.dart';
import 'package:sharedpreferencesapp/src/pages/settings_page.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // el espacio entre la barra de notificacioens y el inicio del Widget ListView()
        // puede rellenarse o completarse con el mismo widget con la propiedad "paddign:EdgeInsets.zero"
        padding: EdgeInsets.zero,
        children: <Widget>[
          //Widget utilizado como cabecera de todo Drawer()
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/menu-img.jpg'),
              fit: BoxFit.cover,
            )),
          ),
          ListTile(
            leading: Icon(
              Icons.pages,
              color: Colors.blue,
            ),
            title: Text('Home'),
            onTap: () =>
                // con el metodo de "NavigatorReplacemetNamed(context, 'Page')" podemos cerrar todos los stacks desde la raiz
                // y dirigirse a la ruta recibida por dicho metodo, es decir a la Page, esto sirve principalmente en caso no queramos mostrar una Page
                // mas de una vez, por ejemplo en slides de introduccion
                Navigator.pushReplacementNamed(context, HomePage.routeName),
          ),
          ListTile(
            leading: Icon(
              Icons.party_mode,
              color: Colors.blue,
            ),
            title: Text('Party Mode'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.blue,
            ),
            title: Text('People'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            title: Text('Settings'),
            onTap: () {
              // la primera opcion para navegar a otra page podria ser usando el "Navigator.pushNamed(context, 'nombrePagina')"
              // el inconveniente con esto es que si volvemos a la pagina anterior encontraremos el Drawer() abierto en la pagina inicial HomePage()
              // una solicion posible es cerrar el drawer antes de navegar a la siguiente page con la siguiente linea
              // Navigator.pop(context);
              // Navigator.pushNamed(context, SettingsPage.routeName);
              // la segunda opcion es mas optima si queremos cerrar todos los demas stacks dede la raiz
              // es decir ya no podremos volver a una page anterior, ni deslizando desde la izquierda ni tampoco aparecera
              // el arrow en la parte superior izquierda con la siguiente linea
              // esta linea tambien seria muy efectiva si es que queremos que el usuario no pueda regresar a unas pages especificas
              // como por ejemplo de una lista de Slides de introduccion a un Login
              Navigator.pushReplacementNamed(context, SettingsPage.routeName);
            },
          )
        ],
      ),
    );
  }
}
