import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/api.dart';
import 'package:favoritos_youtube/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Favorites extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          }
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Favoritos",
          style: TextStyle(
            color: Colors.black
          )
        )
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFavorites,
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((video) {
              return InkWell(
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(
                    apiKey: API_KEY,
                    videoId: video.id
                  );
                },
                onLongPress: () {
                  bloc.toggleFavorite(video);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(video.thumb),
                    ),
                    Expanded(
                      child: Text(
                        video.title,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black
                        )
                      )
                    )
                  ]
                )
              );
            }).toList()
          );
        }
      )
    );
  }
}
