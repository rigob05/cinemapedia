import 'package:cinemapedia/infrastructure/datasources/isar_datasources.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(datasources: IsarDatasources());
});
