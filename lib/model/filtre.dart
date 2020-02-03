class Filtre{

final String marka;

final String model;

final int minFiyat;

final int maxFiyat;

final int minYil;

final int maxYil;

bool isActive;

Filtre({this.marka, this.model, this.minFiyat, this.maxFiyat, this.minYil, this.maxYil, this.isActive});



  static List<Filtre> allFiltres(){
    var lstofFiltres = new List<Filtre>();

    lstofFiltres.add(new Filtre(marka:"Audi",model:"A4",minFiyat:10000,maxFiyat:50000,minYil:1900,maxYil:2020,isActive: true));
    lstofFiltres.add(new Filtre(marka:"Volkswagen",model:"Scirocco",minFiyat:1000,maxFiyat:5000,minYil:1950,maxYil:2009,isActive: true));
    return lstofFiltres;
  }
}