
import 'package:get_it/get_it.dart';
import 'package:newflutter/repository/user_repository.dart';
import 'package:newflutter/services/fake_auth_service.dart';
import 'package:newflutter/services/firebase_auth_service.dart';
import 'package:newflutter/services/firebase_storage_service.dart';

import 'fbdatabase_db_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(()=>FirebaseAuthService());
  locator.registerLazySingleton(()=>FakeAuthenticationService());
  locator.registerLazySingleton(()=>FirebaseDatabaseService());
  locator.registerLazySingleton(()=>UserRepository());
  locator.registerLazySingleton(()=>FirebaseStorageService());

}