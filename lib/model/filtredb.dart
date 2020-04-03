class Filtredb{
  int _id;
  String _marka;
  String _model;
  int _minFiyat;
  int _maxFiyat;
  int _minYil;
  int _maxYil;
  int _isActive;
  int _minkm;
  int _maxkm;
  String _fuel;
  String _transmission;
  String _hp;
  String _color;
  String _location;

  Filtredb(this._marka,this._model,this._minFiyat,this._maxFiyat,this._minYil,this._maxYil,this._isActive,this._minkm,this._maxkm,this._fuel,this._transmission,this._hp,this._color,this._location);
  Filtredb.withId(this._id,this._marka,this._model,this._minFiyat,this._maxFiyat,this._minYil,this._maxYil,this._isActive,this._minkm,this._maxkm,this._fuel,this._transmission,this._hp,this._color,this._location);

  int get id => _id;
	String get marka => _marka;
  String get model => _model;
  int get minFiyat => _minFiyat;
  int get maxFiyat => _maxFiyat;
  int get minYil =>_minYil;
	int get maxYil => _maxYil;
  int get isActive => _isActive;

  int get colminKm => _minkm;
  int get colmaxKm => _maxkm;
  String get colFuel => _fuel;
  String get colTransmission => _transmission;
  String get hp => _hp;
  String get color => _color;
  String get location =>_location;



  set marka(String newmarka) {
		this._marka = newmarka;
	}
  set model(String newmodel) {
		this._model = newmodel;
	}
  set minFiyat(int newminFiyat) {
		this._minFiyat = newminFiyat;
	}
  set maxFiyat(int newmaxFiyat) {
		this._maxFiyat = newmaxFiyat;
	}
  set minYil(int newminYil) {
		this._minYil = newminYil;
	}
  set maxYil(int newmaxYil) {
		this._maxYil = newmaxYil;
	}
  set isActive(int newisActive) {
		this._isActive = newisActive;
	}

  

  set colminKm(int value) {
    _minkm = value;
  }
  set colmaxKm(int value) {
    _maxkm = value;
  }

   // Convert a Filter object into a Map object  

  set colFuel(String value) {
    _fuel = value;
  }

  set colTransmission(String value) {
    _transmission = value;
  }
set hp(String value) {
    _hp = value;
  }
  

  set color(String value) {
    _color = value;
  }

  set location(String value){
    _location=value;
  }

  Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['marka'] = _marka;
		map['model'] = _model;
		map['minfiyat'] = _minFiyat;
		map['maxfiyat'] = _maxFiyat;
    map['minyil'] = _minYil;
    map['maxyil'] = _maxYil;
    map['isactive']=_isActive;
    
    map['minkm']=_minkm;
    map['maxkm']=_maxkm;
    map['fuel']=_fuel;
    map['transmission']=_transmission;
    map['hp']=_hp;
    map['color']=_color;
    map['location']=_location;

		return map;
	}

  // Extract a Note object from a Map object
  Filtredb.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._marka = map['marka'];
		this._model = map['model'];
		this._minFiyat = map['minfiyat'];
		this._maxFiyat = map['maxfiyat'];
    this._minYil = map['minyil'];
    this._maxYil = map['maxyil'];
    this._isActive = map['isactive'];

    this._minkm = map['minkm'];
    this._maxkm = map['maxkm'];
    this._fuel = map['fuel'];
    this._transmission = map['transmission'];
    this._hp=map['hp'];
    this._color=map['color'];
    this._location=map['location'];
	}



}