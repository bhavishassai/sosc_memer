import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sosc_memer/models/meme_response.dart';

void main() {
  runApp(MemeApp());
}

class MemeApp extends StatefulWidget {
  const MemeApp({Key? key}) : super(key: key);

  @override
  _MemeAppState createState() => _MemeAppState();
}

class _MemeAppState extends State<MemeApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<MemeResponse> fetchMemes() async {
    var response =
        await http.get(Uri.parse("https://meme-api.herokuapp.com/gimme/1"));
    Map<String, dynamic> map = jsonDecode(response.body);
    return MemeResponse.fromJson(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SOSC MEMER"),
      ),
      body: Column(
        children: [
          FutureBuilder<MemeResponse>(
            future: fetchMemes(),
            builder:
                (BuildContext context, AsyncSnapshot<MemeResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.network(
                            snapshot.data!.memes[0].url,
                            height: 400,
                            fit: BoxFit.contain,
                            // loadingBuilder: (c, w, chunk) {
                            //   return Center(
                            //     child: Text("Loading ...."),
                            //   );
                            // },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Refresh"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(snapshot.data!.memes[0].subreddit),
                          Text(snapshot.data!.memes[0].title),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text("Failed"),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
