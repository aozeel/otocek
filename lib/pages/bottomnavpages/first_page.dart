import 'package:flutter/material.dart';
import 'package:newflutter/model/city.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FirstPage extends StatelessWidget {
   FirstPage({Key key}) : super(key: key);


 @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: _buildListView(),
      
    );
  }


  Widget _buildListView(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 10,
      itemBuilder: (context,index){
        return _buildImageColumn();
        // ListTile(title: Text("data"),subtitle: Text("Likes:1"),);
      },
    );
  }


  Widget _buildImageColumn() => Container(
    decoration: BoxDecoration(
      color: Colors.blue[50]
    ),
    margin: const EdgeInsets.all(8),
    child: Card(
      child: Column(      
      children: <Widget>[
        image(),
        ilanicerik,
      ],
      
    ),

    ),
  );


   Widget image() => Container(
  child: Stack(// Yazıyı resim içerisinde yazmak için kulanılır   
      alignment: Alignment.bottomRight,//Container ı resmin sağ alt konumuna götürdü   
      children: <Widget>[
        CachedNetworkImage(
        imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSiCcH_vQgsnqw8bJW0hsjPumNFJzoQUEVDXSAc9JjVUYyF4Tab",
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
    ),
       Container(
         padding: EdgeInsets.all(5),
         color: Colors.grey,
         child: Text("fiyat"),
       ) ,
      ],
      
    ),
 ); 



Widget ilanicerik = Container(
      padding: const EdgeInsets.only(bottom: 8,left: 8,top: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Model',
                  ),
                ),
                Text(
                  'Fiyat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [  
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Yıl',
                  ),
                ),
                Text(
                  'Baslik',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text("data"),
                )
              ],
            ),
          ),
        ],
      ),
    );


}