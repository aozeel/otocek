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

  Cardb(this._image,this._price,this._title,this._location,this._model,this._year,this._logo,this._link_detay);
  Cardb.withId(this._id,this._image,this._price,this._title,this._location,this._model,this._year,this._logo,this._link_detay);

  int get id => _id;

	String get image => _image;

  double get price => _price;

  String get title => _title;

  String get location =>_location;

	String get model => _model;

  String get year => _year;

  String get logo => _logo;

  String get link_detay => _link_detay;

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

  // Convert a Note object into a Map object
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
	}



}