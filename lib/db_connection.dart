import 'package:mysql1/mysql1.dart';

Future<MySqlConnection> getConnection() async {
  final settings = ConnectionSettings(
    host: '10.0.2.2',
    port: 3306,
    user: 'root',
    // password: '',
    db: 'losamigos',
  );

  final conn = await MySqlConnection.connect(settings);
  return conn;
}