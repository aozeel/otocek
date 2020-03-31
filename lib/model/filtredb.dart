class Filtredb{
  int _id;
  String _marka;
  String _model;
  int _minFiyat;
  int _maxFiyat;
  int _minYil;
  int _maxYil;
  int _isActive;
  String _km;
  String _fuel;
  String _transmission;
  String _hp;
  String _color;

  Filtredb(this._marka,this._model,this._minFiyat,this._maxFiyat,this._minYil,this._maxYil,this._isActive,this._km,this._fuel,this._transmission,this._hp,this._color);
  Filtredb.withId(this._id,this._marka,this._model,this._minFiyat,this._maxFiyat,this._minYil,this._maxYil,this._isActive,this._km,this._fuel,this._transmission,this._hp,this._color);

  int get id => _id;
	String get marka => _marka;
  String get model => _model;
  int get minFiyat => _minFiyat;
  int get maxFiyat => _maxFiyat;
  int get minYil =>_minYil;
	int get maxYil => _maxYil;
  int get isActive => _isActive;

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

  String get colKm => _km;

  set colKm(String value) {
    _km = value;
  }

  String get hp => _hp;

  set hp(String value) {
    _hp = value;
  } // Convert a Filter object into a Map object

  String get colFuel => _fuel;

  set colFuel(String value) {
    _fuel = value;
  }

  String get colTransmission => _transmission;

  set colTransmission(String value) {
    _transmission = value;
  }

  String get color => _color;

  set color(String value) {
    _color = value;
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
    map['km']=_km;
    map['fuel']=_fuel;
    map['transmission']=_transmission;
    map['hp']=_hp;
    map['color']=_color;

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
    this._km = map['km'];
    this._fuel = map['fuel'];
    this._transmission = map['transmission'];
    this._hp=map['hp'];
    this._color=map['color'];
	}



}