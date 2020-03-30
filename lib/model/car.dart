class Car{
  String image;
  double price;
  String title;
  String location;
  String model;
  String year;
  String logo;

  Car({this.image, this.price, this.title, this.location,this.model,this.year,this.logo});

  static List<Car> getCar(){
    var carList=new List<Car>();

    carList.add(new Car(image:"https://image5.sahibinden.com/photos/26/21/72/thmb_76226217238i.jpg",price:290.000,title:"HATASIZ BOYASIZ 2016 A4 2.0 TDI DESİGN SUNROOF LED ZENON 190HP",
    location:"Niğde Bor",model:"Audi A4 A4 Sedan 2.0 TDI Design",year:"2016",logo:"sahibinden.PNG"));
    
    carList.add(new Car(image:"https://image5.sahibinden.com/photos/66/00/77/thmb_7846600779f4.jpg",price:75.500,title:"2016 MODEL RENAULT CLİO 1.5 dci JOY HATASIZ - BOYASIZZ",
    location:"Antalya Demre",model:"Renault Clio 1.5 dCi Joy",year:"2016",logo:"sahibinden.PNG"));
    
    carList.add(new Car(image:"https://s0.shbdn.com/assets/images/iconHasMegaPhoto:1d086aab554fd92d49d3762a0542888a.png",price:82.500,title:"Volkswagen Jetta 1.6 TDi Trendline",
    location:"İstanbul Sancaktepe",model:"wosvogen Jetta 2013",year:"2013",logo:"sahibinden.PNG"));
    
    carList.add(new Car(image:"https://s0.shbdn.com/assets/images/iconHasMegaPhoto:1d086aab554fd92d49d3762a0542888a.png",price:124.00,title:"temiz servis bakımlı araç",
    location:"Ankara Gölbaşı",model:"Peugeot 308 1.6 e-HDi Classic Edition Plus",year:"2016",logo:"sahibinden.PNG"));
    
    carList.add(new Car(image:"https://arbimg29.mncdn.com/ilanfotograflari/2020/01/25/13515726/b8f5b0b1-5972-4679-957b-ef625460bab6_image_for_silan_13515726_120x90.jpg",price:13.750,title:"Galeriden Hyundai Excel 1.5 GLS 1993 Model Mardin",
    location:"Mardin Midyat",model:"Audi A4 A4 Sedan 2.0 TDI Design",year:"1993",logo:"arabam.png"));
    
    carList.add(new Car(image:"https://arbimg30.mncdn.com/ilanfotograflari/2020/01/28/13539817/80f8b4ad-956e-4685-8c4c-a268d36817ba_image_for_silan_13539817_120x90.jpg",price:58.500,title:"Sahibinden Fiat Fiorino Fiorino Combi 1.4 Fire Premio 2018 Model",
    location:"İstanbul Arnavutköy",model:"Fiat Fiorino Fiorino Combi 1.4 Fire Premio",year:"2018",logo:"arabam.png"));
    
    carList.add(new Car(image:"https://arbimg29.mncdn.com/ilanfotograflari/2020/01/28/13539795/c73d2ffe-d7fc-4fa1-843d-e36b72b18974_image_for_silan_13539795_120x90.jpg",price:55.250,title:"Sahibinden Volkswagen Passat 1.6 FSi Trendline 2007 Model",
    location:"Gaziantep Şehitkamil",model:"Volkswagen Passat 1.6 FSi Trendline",year:"2007",logo:"arabam.png"));

    carList.add(new Car(image:"https://arbimg1.mncdn.com/ilanfotograflari/noImage/01/01/1/noimage5_120x90.jpg",price:290.00,title:"Sahibinden Daelim S3 Advance 250",
    location:"Aksaray Ağaçören",model:"Daelim S3 Advance 250",year:"2018",logo:"arabam.png"));

    return carList;
  }


  static List<Car> getFavori(){
    var carList=new List<Car>();

    carList.add(new Car(image:"https://image5.sahibinden.com/photos/26/21/72/thmb_76226217238i.jpg",price:290.000,title:"HATASIZ BOYASIZ 2016 A4 2.0 TDI DESİGN SUNROOF LED ZENON 190HP",
    location:"Niğde Bor",model:"Audi A4 A4 Sedan 2.0 TDI Design",year:"2016",logo:"sahibinden.PNG"));

    carList.add(new Car(image:"https://arbimg29.mncdn.com/ilanfotograflari/2020/01/28/13539795/c73d2ffe-d7fc-4fa1-843d-e36b72b18974_image_for_silan_13539795_120x90.jpg",price:55.250,title:"Sahibinden Volkswagen Passat 1.6 FSi Trendline 2007 Model",
    location:"Gaziantep Şehitkamil",model:"Volkswagen Passat 1.6 FSi Trendline",year:"2007",logo:"arabam.png"));

    return carList;
  }



}