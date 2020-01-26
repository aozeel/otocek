import 'package:flutter/material.dart';

class FifthPage extends StatelessWidget {
  const FifthPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foos = 'Genel';
    final title = 'profil';

        return MaterialApp(
          title: title,
          home: Scaffold(
            appBar: AppBar(
              title: Text(title),
              backgroundColor: Colors.amber,
            ),
            
            body:
            new ExpansionTile(
              title: new Text(foos),
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Ayarlar'),
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Destek Al'),
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text('Hakkımızda'),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Cihaz Bilgisi'),
                ),
                ListTile(
                  leading: Icon(Icons.power_settings_new,color: Colors.red,),
                  title: Text('Çıkış Yap'),
                ),
              ]
            ),
          
          ),
        );
      }
    
      Widget addProfile() {
       return new Container(
    width: 200,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.pink,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album, size: 70),
            title: Text('Heart Shaker', style: TextStyle(color: Colors.white)),
            subtitle: Text('TWICE', style: TextStyle(color: Colors.white)),
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Edit', style: TextStyle(color: Colors.white)),
                  onPressed: () {},
                ),
                FlatButton(
                  child: const Text('Delete', style: TextStyle(color: Colors.white)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
      }
}