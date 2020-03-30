class Filtredb{
  int _id;
  String _marka;
  String _model;
  int _minFiyat;
  int _maxFiyat;
  int _minYil;
  int _maxYil;
  int _isActive;

  Filtredb(this._marka,this._model,this._minFiyat,this._maxFiyat,this._minYil,this._maxYil,this._isActive);
  Filtredb.withId(this._id,this._marka,this._model,this._minFiyat,this._maxFiyat,this._minYil,this._maxYil,this._isActive);

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

   // Convert a Filter object into a Map object
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
	}
  
}