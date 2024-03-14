import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'keys.env', useConstantCase: true, obfuscate: true)
abstract class Env {
    @EnviedField(varName: 'KEY1', obfuscate: true)
    static final String key1 = _Env.key1;
    @EnviedField(varName: 'KEY2', obfuscate: true)
    static final String key2 = _Env.key2;
}