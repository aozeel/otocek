class Cardb{
  int _id;
  String _image;
  double _price;
  String _title;
  String _location;
  String _model;
  String _year;
  String _logo;
  String _link_detay;
  String _km;
  String _fuel;
  String _transmission;
  String _hp;
  String _color;

  Cardb(this._image,this._price,this._title,this._location,this._model,this._year,this._logo,this._link_detay,this._km,this._fuel,this._transmission,this._hp,this._color);
  Cardb.withId(this._id,this._image,this._price,this._title,this._location,this._model,this._year,this._logo,this._link_detay,this._km,this._fuel,this._transmission,this._hp,this._color);

  int get id => _id;

	String get image => _image;

  double get price => _price;

  String get title => _title;

  String get location =>_location;

	String get model => _model;

  String get year => _year;

  String get logo => _logo;

  String get link_detay => _link_detay;

  String get km => _km;

  set km(String value) {
    _km = value;
  }

  set date(String newimage) {
		this._image = newimage;
	}
  set price(double newprice) {
		this._price = newprice;
	}
  set title(String newtitle) {
		this._title = newtitle;
	}
  set location(String newlocation) {
		this._location = newlocation;
	}
  set model(String newmodel) {
		this._model = newmodel;
	}
  set year(String newyear) {
		this._year = newyear;
	}
  set logo(String newlogo) {
		this._logo = newlogo;
	}
  set link_detay(String newlink_detay){
    this._link_detay=newlink_detay;
  }

  String get fuel => _fuel;

  set fuel(String value) {
    _fuel = value;
  }// Convert a Note object into a Map object


  String get Fuel => _fuel;

  String get Transmission => _transmission;

  set Transmission(String value) {
    _transmission = value;
  }

  set Fuel(String value) {
    _fuel = value;
  }

  String get transmission => _transmission;

  String get color => _color;

  set color(String value) {
    _color = value;
  }

  String get hp => _hp;

  set hp(String value) {
    _hp = value;
  }

  set transmission(String value) {
    _transmission = value;
  }


  Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['image'] = _image;
		map['price'] = _price;
		map['title'] = _title;
		map['model'] = _model;
    map['year'] = _year;
    map['logo'] = _logo;
    map['location']=_location;
    map['link_detay']=_link_detay;
    map['km']=km;
    map['fuel']=_fuel;
    map['transmission']=_transmission;
    map['hp']=_hp;
    map['color']=_color;

		return map;
	}

  // Extract a Note object from a Map object
  Cardb.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._title = map['title'];
		this._image = map['image'];
		this._price = map['price'];
		this._model = map['model'];
    this._year = map['year'];
    this._logo = map['logo'];
    this._location=map['location'];
    this._link_detay=map['link_detay'];
    this._km=map['km'];
    this._fuel=map['fuel'];
    this._transmission=map['transmission'];
    this._hp=map['hp'];
    this._color=map['color'];
	}



}