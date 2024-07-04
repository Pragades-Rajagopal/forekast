import 'package:flutter/services.dart';

Future<Map<String, String>> parseEnvFile(
    {String assetsFileName = '.env'}) async {
  final lines = await rootBundle.loadString(assetsFileName);
  Map<String, String> envData = {};
  for (String line in lines.split('\n')) {
    line = line.trim();
    if (line.contains('=') && !line.startsWith(RegExp(r'=|#'))) {
      List<String> contents = line.split('=');
      envData[contents[0]] = contents.sublist(1).join('=');
    }
  }
  return envData;
}
