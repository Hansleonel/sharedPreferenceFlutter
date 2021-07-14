// el objetivo de crear esta class que tendra propieades y metodos que se usaran como Singleton
// sera obtener todos los valores desde nuestro sharedPreferences antes de que cualquier StatlessWidget
// sea inizialidado, puesto que como sabemos para obtener los valores almancenados dentro del SharedPreference
// debemos de usar Futures y Awaits, dicho uso no esta permitido dentro de los metodos Build() de nuestros StatelesWidgets
// a diferencia de los StateFulWidgets en los que podemos manejar dichos futures y awaits con los metodos del ciclo de vida
// como el initState, es por eso que haremos el llamado a esta class antes de la construcccion de todos los Widgets ya sean StateFul
// o StateLess para que se tengan los valores del SharedPrefernces antes de cualquier Build de cualquier Widget
// esto nos permite almacenar incluso la Page donde nos encontramos y asi hacer una validacion y entrar directamente a dicha Page
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  // Constructor que como vemos es del tipo factory esto solo creara una unica instancia de dicha clase SharedPreferenceUser
  // y en caso que ya este creada devolvera la misma, normalmente se usa el factory cuando hacemos uso del patron Singleton
  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  // metodo que nos permite obtener la instancia del SharedPreferences
  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // metodo get para obtener el valor almaceando de nuestro genero desde el SharedPreferences
  // y con la clave "genero"
  get getGenero {
    // con esta linea no solo accedemos al valor de la llave "genero" sino tambien hacemos una validacion
    // para que en caso no encuentre dicho valor la asignacion sera 1
    return _prefs.getInt('gender') ?? 1;
  }

  set setGenero(int valorGenero) {
    _prefs.setInt('gender', valorGenero);
  }

  get getSecondaryColor {
    // con esta linea no solo accedemos al valor de la llave "colorSecundario" sino tambien hacemos una validacion
    // para que en caso no encuentre dicho valor la asignacion sera false
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set setSecondaryColor(bool valorColor) {
    _prefs.setBool('colorSecundario', valorColor);
  }

  get getName {
    // con esta linea no solo accedemos al valor de la llave "nombreUsuario" sino tambien hacemos una validacion
    // para que en caso no encuentre dicho valor la asignacion sera ''
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set setName(String nombreUser) {
    _prefs.setString('nombreUsuario', nombreUser);
  }

  // en este caso cremos este getter para obtener desde nuestro SharedPreferences la ruta de la pagina donde el user se encontro antes de
  // slir de la aplicacion, en caso no encontremos dicho valor la asignacion para la ruta de la pagina a la ruta "home"
  get getPageUser {
    return _prefs.getString('pageUser') ?? 'home';
  }

  set setPageUser(String page) {
    _prefs.setString('pageUser', page);
  }
}
