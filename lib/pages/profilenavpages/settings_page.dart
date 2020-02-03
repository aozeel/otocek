import 'package:flutter/material.dart';
import 'package:newflutter/pages/bottomnavpages/fifth_page.dart';



class SettingsPage extends StatelessWidget {

const SettingsPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,15.0,10.0,0),

        child: ListView(
          children: <Widget>[
            FifthPage().profileInfos(context),

            Divider(),
            Container(height: 15.0),

            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "Üyelik Bilgileri".toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              title: Text(
                "Ad Soyad",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "Jane Mary Doe",
              ),

              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: (){
                },
                tooltip: "Edit",
              ),
            ),

            ListTile(
              title: Text(
                "E-Posta",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "jane@doefamily.com",
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: (){
                },
                tooltip: "Edit",
              ),
            ),
            

            ListTile(
              title: Text(
                "Cep Telefonu",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "+90 555-880-2222",
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: (){
                },
                tooltip: "Edit",
              ),
            ),

            ListTile(
              title: Text(
                "Şifre",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "**********",
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: (){
                },
                tooltip: "Edit",
              ),
            ),


          /*  ListTile(
              title: Text(
                "Dark Theme",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              trailing: Switch(
                value: Provider.of<AppProvider>(context).theme == Constants.lightTheme
                    ? false
                    : true,
                onChanged: (v) async{
                  if (v) {
                    Provider.of<AppProvider>(context, listen: false)
                        .setTheme(Constants.darkTheme, "dark");
                  } else {
                    Provider.of<AppProvider>(context, listen: false)
                        .setTheme(Constants.lightTheme, "light");
                  }
                },
                activeColor: Theme.of(context).accentColor,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}