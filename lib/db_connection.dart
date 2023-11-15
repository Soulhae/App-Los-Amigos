import 'package:mysql1/mysql1.dart';

Future<MySqlConnection> getConnection() async {
  final settings = ConnectionSettings(
    host: 'bin07922repd91xmnlyb-mysql.services.clever-cloud.com',
    port: 3306,
    user: 'ugs2mmjtbmbjl9rc',                                              //bd en la nube
    password: 'Chq20qLy7TGZSnrdZ9JX',
    db: 'bin07922repd91xmnlyb',
  );
  // final settings = ConnectionSettings(
  //   host: '10.0.2.2',
  //   port: 3306,
  //   user: 'root',                                                           //bd local con XAMPP
  //   password: '',
  //   db: 'losamigosnueva',
  // );
  // print(settings.host);
  // print(settings.port);
  // print(settings.user);
  // print(settings.password);
  // print(settings.db);
  final conn = await MySqlConnection.connect(settings);  
  return conn;
}