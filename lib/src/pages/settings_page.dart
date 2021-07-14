import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreferencesapp/src/utils/preferencias_usuario.dart';
import 'package:sharedpreferencesapp/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {
  // nombre de la ruta almacenada dentro de una variable static final
  // con el nombre de "routeName" para manejar las rutas dentro de nuestro Widget Principal Main()
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _colorSwitchButtonValue;
  int _genderRadioButton;
  String _nameTextField = 'Nombre01';

  // para poder insertar texto predeterminado directamente dentro de un Widget TextField()
  // debemos de utilizar un TextEditingController, ademas debemos de inicializar el valor de este TextEditingController
  // dentro de initState(), todo esto porque el valor del init controller debe de realizarce antes de que
  // se llame al metodo build(), dicho initState() es llamado antes de el metodo build() porque que como sabemos es parte de nuestro ciclo de vida de el Widget
  TextEditingController _textEditingController;

  // usamos la unica instancia que puede generar el constructor de tipo factory de nuestro Singleton
  // para obtener las instancia y metodos para manejar nuestro sharedPreference
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // usando la instancia pref para grabar la page con el setter de dicha instancia singleton
    prefs.setPageUser = SettingsPage.routeName;

    // llamando a nuestro metodo cargarPref() antes que otra inializacion puesto que aqui se almacenara todos los valores
    // iniciales que hayamos guardado
    // en la actualizacion vemos que hemos creado un singleton para el manejo de las intancias de nuestro sharedPreferences
    // es por eso que podemos usar los getters y los setters de los valores guardados dentro de el SharedPreference
    // cargarPref();
    // en este caso para obtener el valor del genero desde nuestro SharedPreference solo neesitamos usar la instancia y el getter
    // para genenro es decir getGenero recordemos que Dart trata a los getters y setters como propiedades y no como metodos
    _genderRadioButton = prefs.getGenero;
    _colorSwitchButtonValue = prefs.getSecondaryColor;
    _nameTextField = prefs.getName;
    // inicializando la varaiable "textEditingController" dentro del metodo initState()
    // para que cuando se llame al metodo build() dicho "textEditingController" ya tenga un valor que usar
    _textEditingController = new TextEditingController(text: _nameTextField);
  }

  //metodo para cargar los valores guardados dentro de nuestro SharedPreference
  cargarPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _genderRadioButton = prefs.getInt('gender');
    // para que podamos ver la modificacion una ves cargados los valores desde el SharedPreferences
    // debemos de llamar a nuestro setState((){})
    setState(() {});
  }

  // creando un metodo para la seleccion de RadioListTile en este caso tenemos que volverla Async
  // puesto que usaremos el SharedPreference que es usara un await
  _setSelectedRadio(int valorRadio) async {
    // recordemos que cuando en Dart los getters y los setters son tratados como propiedades
    // y no como metodos, es por eso que igualamos el metodo .setGenero a valorRadio
    // esto nos permite guardar en nuestro SharedPreferences el valor de nuestro genero
    prefs.setGenero = valorRadio;
    _genderRadioButton = valorRadio;
    setState(() {});
    // TODO grabando el valor de nuestra variable "_genderRadioButton" en nuestro SharedPreferences en Android
    // y en Wraps NSUserDefaults en iOS

    // Con la actualizacionn y el uso de el singleton para nuestro SharedPreference no necesitamos grabar el valor
    // del genero instanciando de nunevo el SharedPreferences, solo necesitamos usar los getters y los setters
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt('gender', valorRadio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // estableciendo el color de nuestro AppBar de acuerdo al valor almacenado dentro de nuestro SharedPreferences
          // ademas tambien usaremos el setState de nuestro Widget SwitchListTile() para poder actalizar dicho color
          backgroundColor:
              (prefs.getSecondaryColor) ? Colors.teal : Colors.blue,
          title: Text('Settings Page'),
        ),
        // usando un Widget Personalizado en este caso el Widget DrawerWidget()
        // que retrnra el Widget Drawer() dicho Widget tiene los enrutamientos necesarios
        // ademas como vemos no enviamos el BuildContext context porque dicho Widget ya tienen un context
        // donde construirse y no es necesario indicarle de manera nominal que haga el Build en este context
        // puesto que como mencionamos tiene su propio context
        drawer: DrawerWidget(),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            SwitchListTile(
                value: _colorSwitchButtonValue,
                title: Text('Secondary Color'),
                onChanged: (valorSwitch) {
                  // en caso de que hagamos click a nuestro SwitchListTile el valor de "_colorSwitchButtonValue" se modificara
                  _colorSwitchButtonValue = valorSwitch;
                  // usando la instancia de nuestro singleton para grabar el valor de nuestro "_colorSwitchButtonValue" dentro
                  // de nuestro SharedPreference
                  prefs.setSecondaryColor = valorSwitch;
                  // en caso hagamos click a nuestro SwitchListTile debemos de redibujr el WidgetCompleto para ver la interaccion de dicho SwitchListTile
                  setState(() {});
                }),
            Divider(),
            RadioListTile(
                value: 1,
                title: Text('Femenino'),
                // como vemos si queremos tener multiples RadioListTile() deben de pertenecer al mismo grupo
                // es decir la propiedad "groupValue" debe de ser el mismo a diferencia de la propiedad "value" que deben de ser diferentes
                // puesto que deben de ser unicas por cada RadioListTile()
                groupValue: _genderRadioButton,
                onChanged: (_setSelectedRadio)),
            RadioListTile(
                value: 2,
                title: Text('Masculino'),
                groupValue: _genderRadioButton,
                // la propiedad "onChanged" recibira como valor una funcion que en este caso declaramos en la parte superior
                // que tiene el mismo fucionamiento si es que la declaramos como funcion anonima "(valor){}""
                onChanged: _setSelectedRadio),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    labelText: 'Nombre', helperText: 'Nombre de la persona'),
                onChanged: (valorTextField) {
                  prefs.setName = valorTextField;
                },
              ),
            )
          ],
        ));
  }
}
