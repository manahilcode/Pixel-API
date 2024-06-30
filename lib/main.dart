import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pexel_api/dartt.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main()=>runApp(
  MaterialApp(
    home: pexels(),
    debugShowCheckedModeBanner: false ,
  )
);
class pexels extends StatefulWidget {
  const pexels({Key? key}) : super(key: key);

  @override
  State<pexels> createState() => _pexelState();
}

class _pexelState extends State<pexels> {
  @override


  Widget build(BuildContext context) => Scaffold(

      body: SafeArea(
        child: FutureBuilder(
          future: pixels().getpexels('https://api.pexels.com/v1/curated?per_page=5'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("hi");
              print(snapshot.data);
              List<dynamic> data = snapshot.data.photos;
              print(data);

              return ListView.builder(


                itemCount: data.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: data[index].src.medium,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                },
              );
            } else if (snapshot.hasError) {
              print("hi2");
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },

      ),
      ),
    );


}
class pixels {
  Future getpexels(String image) async {
    print("before");
    final response = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=5"), headers: {
      "Authorization": "oi3HPKa2MsWsYCBjsD3PfsF9bqV7BQXwAOonb81sgbTUwnaNnVo9ti11"
    });


    // final response = await http.get(uri);
    print('after');
    if (response.statusCode == 200) {
      return pexel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    else {
      //TODO:Throw error here
    }
  }
}
