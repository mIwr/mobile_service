
import 'dart:io';

extension FsEntityExt on FileSystemEntity {

  String get entityName {
    final pathSegments = uri.pathSegments;
    if (pathSegments.isEmpty) {
      return path;
    }
    final name = pathSegments[pathSegments.length - 1];

    return name;
  }
}