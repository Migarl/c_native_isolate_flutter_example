import 'dart:async';
import "dart:ffi";
import "dart:io";

import "package:ffi/ffi.dart";
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

DynamicLibrary getLibrary() {
  late String libPath;
  if (Platform.isWindows) {
    libPath = "libgreet.dll";
  } else if (Platform.isMacOS) {
    libPath = "../Resources/libgreet.dylib";
  } else if (Platform.isLinux) {
    libPath =
        p.join(p.dirname(Platform.resolvedExecutable), "lib", "libgreet.so");
  }
  return DynamicLibrary.open(libPath);
}

typedef NativeGreetFunc = Pointer<Utf8> Function(
  Pointer<Utf8>,
);

typedef GreetFunc = Pointer<Utf8> Function(
  Pointer<Utf8> name,
);

String _greet(String name) {
  final lib = getLibrary();
  final GreetFunc greet =
      lib.lookup<NativeFunction<NativeGreetFunc>>("greet").asFunction();
  return greet(name.toNativeUtf8()).toDartString();
}

Future<String> greet({String name = "World"}) async {
  return await compute(_greet, name);
}
