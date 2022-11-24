import 'package:flutter/material.dart';

import 'infoPet.dart';
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();

}
class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    return ListView(
      children: <Widget>[

        Container(
        padding: EdgeInsets.all(20.0),
        child: Image.network("https://www.hogarmania.com/archivos/202004/chequeo-veterinario-en-gatos-recogidos-de-la-calle-668x400x80xX-1.jpg"),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return InfoPet();
                      }));
                },
                child: const Text('CONOCER'),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: Image.network("https://static.nationalgeographic.es/files/styles/image_3200/public/01-stray-dogs-nationalgeographic_1927666.webp?w=1600&h=900"),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {},
                child: const Text('CONOCER'),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: Image.network("https://img.asmedia.epimg.net/resizer/G-X_bUJlma1cEJUBf_yD41j5wnE=/1288x725/cloudfront-eu-central-1.images.arcpublishing.com/diarioas/TWA6R5SDKBL4PIAHDH6VB7FHU4.jpg"),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {},
                child: const Text('CONOCER'),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: Image.network("https://trome.pe/resizer/W5oza_UkfSSWzWXqag1ldo2K9PI=/580x330/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/HG7KTJWBUFH3XKOTIE4I745XXQ.jpg"),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {},
                child: const Text('CONOCER'),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: Image.network("https://cdn0.bioenciclopedia.com/es/posts/5/3/5/conejo_535_600.webp"),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {},
                child: const Text('CONOCER'),
              ),
            ],
          ),
        ),
      ]


    );
  }


}