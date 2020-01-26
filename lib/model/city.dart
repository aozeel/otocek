class City {

final String name;

final String image;

final String population;

final String country;

City({this.name, this.country, this.population, this.image});

static List<City> allCities(){
  var lstOfCities = new List<City>();

  lstOfCities.add(new City(name:"Sahibinden Volkswagen Caddy 1.9 SDI 2005 Model", country:"38.500 TL", population:"Volkswagen Caddy 1.8 SDI", image: "berlin.png"));
  lstOfCities.add(new City(name:"Test2", country:"EveryWhere", population:"0 Mill.", image: "berlin.png"));
  lstOfCities.add(new City(name:"Test3", country:"Somewhere", population:"X Mill.", image: "berlin.png"));
  lstOfCities.add(new City(name:"Test4", country:"Everywhere", population:"X Mill.", image: "berlin.png"));

  return lstOfCities;
}
}