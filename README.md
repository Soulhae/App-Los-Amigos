# App-Los-Amigos

Vicente Salinas, Eyleen Sánchez, Benjamín Herrera

## Detalles de desarrollo

|                          |                                                                                      |
| ------------------------ | -------------------------------------------------------------------------------------|
| **IDEs/Editor**          | [![VsCode]][VsCodeWeb]                                                               |
| **Lenguajes y entornos** | [![Dart]][DartWeb] [![AndroidStudio]][AndroidStudioWeb] [![FlutterBadge]][FlutterWeb]|
| **Utilidades**           | [![MySQL]][MySQLWeb]                                                                 |

### Ejecución del código

* Si desea ejecutar el código requiere de instalar Flutter y todas sus dependencias, por razones de comodidad añadimos el apk al repositorio.
* La base de datos se encuentra en un hosting gratuito de clever-cloud, añadimos también una copia de esta.
* En caso de que no funcione la conexión a la base de datos, importar localmente en XAMPP el archivo `recursos(bd_y_apk)/losamigos.sql` y modificar las variables de configuración en `lib/db_connection.dart`

```
    Credenciales para inicio de sesión:  Usuario    Contraseña
               (Usuario con productos):   user       password
               (Usuario sin productos):   vacio      password
```

[FlutterBadge]:https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white
[FlutterWeb]:https://flutter.dev
[VsCode]:https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white
[VsCodeWeb]:https://code.visualstudio.com
[Dart]:https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white
[DartWeb]:https://dart.dev
[AndroidStudio]:https://img.shields.io/badge/Android%20Studio-3DDC84.svg?style=for-the-badge&logo=android-studio&logoColor=white
[AndroidStudioWeb]:https://developer.android.com/studio
[MySQL]:https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white
[MySQLWeb]:https://www.mysql.com