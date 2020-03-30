import 'package:flutter/material.dart';
import 'package:newflutter/utils/const.dart';



class AboutusPage extends StatelessWidget {
  const AboutusPage({Key key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Alganos Bilişim',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'İstanbul, Türkiye',
                  style: TextStyle(
                    color: Constants.grey500,
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'ARA'),
          _buildButtonColumn(color, Icons.near_me, 'YOL TARİFİ'),
          _buildButtonColumn(color, Icons.share, 'PAYLAŞ'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '+
        'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud '+
        'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute '+
        'irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '+
        'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: 'Hakkımızda',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hakkımızda'),
          backgroundColor: Constants.primaryColor,
        ),
        body: ListView(
          children: [
            Image.asset(
              'assets/berlin.png',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}