import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:my_movies/src/models/trailer_model.dart';
import '../models/item_model.dart';

class MovieApiProvider{
  Client client = Client();
  final _apiKey = 'cac423186cc94ed8ff781e335ea86737';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<ItemModel> fetchMovieList() async {
    print('Entered...');
    final response = await client.get("$_baseUrl/popular?api_key=$_apiKey");
    print(response.body.toString());
    if(response.statusCode == 200){
      return ItemModel.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer (int movieId) async {
    final response = await client.get('$_baseUrl/$movieId/videos?api_key=$_apiKey');

    if(response.statusCode == 200){
      return TrailerModel.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load trailers');
    }
  }
}