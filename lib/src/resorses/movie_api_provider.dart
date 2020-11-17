import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import '../models/item_model.dart';
import '../models/trailer_model.dart';
import 'package:inject/inject.dart';


class MovieApiProvider{
  final Client client;
  final _apiKey = 'api-key';
  // cac423186cc94ed8ff781e335ea86737
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  @provide
  MovieApiProvider(this.client);

  Future<ItemModel> fetchMovieList() async {
    print('Entered...');
    Response response;
    if(_apiKey !='api-key'){
      response = await client.get("$_baseUrl/popular?api_key=$_apiKey");
    }else{
      throw Exception('Please enter your api key');
    }
    if(response.statusCode == 200){
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    }else{
      throw Exception('failed to load post');
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