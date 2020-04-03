import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:newflutter/model/cardb.dart';
import 'package:newflutter/model/filtredb.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;  

  String carTable = 'car_table';

	String colId = 'id';
	String colTitle = 'title';
  String colImage = 'image';
  String colPrice = 'price';
  String colLocation = 'location';
  String colModel = 'model';
  String colYear = 'year';
  String colLogo = 'logo';
  String colLinkDetay = 'link_detay';
  String colKm='km';
  String colfuel='fuel';
  String coltransmission='transmission';
  String colhp='hp';
  String colcolor='color';

  String filtreTable = 'filtre_table';

  String colMarka='marka';
  //String colModel
  String colMinFiyat='minfiyat';
  String colMaxFiyat='maxfiyat';
  String colMinYil = 'minyil';
  String colMaxYil ='maxyil';
  String colIsActive ='isactive';

  String colMinkm ='minkm';
  String colMaxkm ='maxkm';
  //colfuel
  //coltransmission
  //colhp
  //colcolor
  //colLocation


  String favTable ='favori_table';


  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

  Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

  Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'cars.db';

		// Open/create the database at a given path
		var carsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return carsDatabase;
	}

  void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $carTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
				'$colImage TEXT, $colPrice DOUBLE, $colLocation TEXT, $colModel TEXT,$colYear TEXT, $colLogo TEXT, $colLinkDetay TEXT, $colKm TEXT,$colfuel TEXT,$coltransmission TEXT,$colhp TEXT,$colcolor TEXT)');

    await db.execute('CREATE TABLE $filtreTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colMarka TEXT, '
    '$colModel TEXT, $colMinFiyat INTEGER, $colMaxFiyat INTEGER, $colMinYil INTEGER, $colMaxYil INTEGER, $colIsActive INTEGER,$colMinkm INTEGER,$colMaxkm INTEGER, $colfuel TEXT,$coltransmission TEXT,$colhp TEXT,$colcolor TEXT,$colLocation TEXT)');

    await db.execute('CREATE TABLE $favTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
				'$colImage TEXT, $colPrice DOUBLE, $colLocation TEXT, $colModel TEXT,$colYear TEXT, $colLogo TEXT, $colLinkDetay TEXT,$colKm TEXT,$colfuel TEXT,$coltransmission TEXT,$colhp TEXT,$colcolor TEXT)');
	}


  // Fetch Operation: Get all car objects from database
	Future<List<Map<String, dynamic>>> getCarMapList() async {
		Database db = await this.database;

//	var result = await db.rawQuery('SELECT * FROM $carTable order by $colPriority ASC');
		var result = await db.query(carTable, orderBy: '$colId ASC');
		return result;
	}

  Future<List<Map<String, dynamic>>> getFiltreMapList() async {
		Database db = await this.database;

//	var result = await db.rawQuery('SELECT * FROM $carTable order by $colPriority ASC');
		var result = await db.query(filtreTable, orderBy: '$colId ASC');
		return result;
	}

    Future<List<Map<String, dynamic>>> getActiveFiltreMapList() async {
		Database db = await this.database;

//	var result = await db.rawQuery('SELECT * FROM $carTable order by $colPriority ASC');
		var result = await db.query(filtreTable, orderBy: '$colId ASC',where: '$colIsActive = ?', whereArgs: [1]);
		return result;
	}

  	Future<List<Map<String, dynamic>>> getFavMapList() async {
		Database db = await this.database;

//	var result = await db.rawQuery('SELECT * FROM $carTable order by $colPriority ASC');
		var result = await db.query(favTable, orderBy: '$colId ASC');
		return result;
	}

  // Insert Operation: Insert a Car object to database
	Future<int> insertCar(Cardb cardb) async {
		Database db = await this.database;
		var result = await db.insert(carTable, cardb.toMap());
		return result;
	}

  //Insert Operation: Insert a new Filter
  Future <int> insertFiltre(Filtredb filtredb) async{
    Database db = await this.database;
    var result = await db.insert(filtreTable, filtredb.toMap());
    return result;
  }

  // Insert Operation: Insert a Car object to database
	Future<int> insertFav(Cardb cardb) async {
		Database db = await this.database;
		var result = await db.insert(favTable, cardb.toMap());
		return result;
	}


  // Update Operation: Update a Car object and save it to database
	Future<int> updateCar(Cardb cardb) async {
		var db = await this.database;
		var result = await db.update(carTable, cardb.toMap(), where: '$colId = ?', whereArgs: [cardb.id]);
		return result;
	}

  Future <int> updateFilt(Filtredb filtredb) async{
    var db =await this.database;
    var result = await db.update(filtreTable,filtredb.toMap(), where: '$colId = ?', whereArgs: [filtredb.id]);
    return result;
  }

  // Delete Operation: Delete a Car object from database
	Future<int> deleteCar(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $carTable WHERE $colId = $id');
		return result;
	}
//Delete Operation: Delete a filter object from db
  Future<int> deleteFiltre(int id) async{
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $filtreTable WHERE $colId = $id');
    return result;
  }

    // Delete Operation: Delete a Car object from database
	Future<int> deleteFav(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $favTable WHERE $colId = $id');
		return result;
	}

  // Get number of Car objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $carTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

  Future<int> getFiltreCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $filtreTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Car List' [ List<Car> ]
	Future<List<Cardb>> getCarList() async {

		var carMapList = await getCarMapList(); // Get 'Map List' from database
		int count = carMapList.length;         // Count the number of map entries in db table

		List<Cardb> carList = List<Cardb>();
		// For loop to create a 'Car List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			carList.add(Cardb.fromMapObject(carMapList[i]));
		}

		return carList;
	}

  Future<List<Filtredb>> getFiltreList() async {

		var filtreMapList = await getFiltreMapList(); // Get 'Map List' from database
		int count = filtreMapList.length;         // Count the number of map entries in db table

		List<Filtredb> filtreList = List<Filtredb>();
		// For loop to create a 'Filtre List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			filtreList.add(Filtredb.fromMapObject(filtreMapList[i]));
		}

		return filtreList;
	}

    Future<List<Filtredb>> getActiveFiltreList() async {

		var filtreMapList = await getActiveFiltreMapList(); // Get 'Map List' from database
		int count = filtreMapList.length;         // Count the number of map entries in db table

		List<Filtredb> filtreList = List<Filtredb>();
		// For loop to create a 'Filtre List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			filtreList.add(Filtredb.fromMapObject(filtreMapList[i]));
		}

		return filtreList;
	}





  	Future<List<Cardb>> getFavList() async {

		var favMapList = await getFavMapList(); // Get 'Map List' from database
		int count = favMapList.length;         // Count the number of map entries in db table

		List<Cardb> favList = List<Cardb>();
		// For loop to create a 'Car List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			favList.add(Cardb.fromMapObject(favMapList[i]));
		}

		return favList;
	}



}