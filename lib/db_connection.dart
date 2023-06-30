import 'package:mysql1/mysql1.dart';

Future<MySqlConnection> getConnection() async {
  final settings = ConnectionSettings(
    host: 'bin07922repd91xmnlyb-mysql.services.clever-cloud.com',
    port: 3306,
    user: 'ugs2mmjtbmbjl9rc',
    password: 'Chq20qLy7TGZSnrdZ9JX',
    db: 'bin07922repd91xmnlyb',
  );

  final conn = await MySqlConnection.connect(settings);
  return conn;
}