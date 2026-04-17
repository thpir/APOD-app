import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'keys.env', useConstantCase: true, obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'APOD_API_KEY', obfuscate: true)
  static final String apodApiKey = _Env.apodApiKey;
  @EnviedField(varName: 'NEWS_API_KEY', obfuscate: true)
  static final String newsApiKey = _Env.newsApiKey;
}
