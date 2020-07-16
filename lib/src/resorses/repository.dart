import 'dart:async';
import 'package:my_movies/src/models/trailer_model.dart';

import 'movie_api_provider.dart';
import '../models/item_model.dart';

  class Repository{
    final movieApiProvider = MovieApiProvider();

    Future<ItemModel> fetchAllMovies() => movieApiProvider.fetchMovieList();
    
    Future<TrailerModel> fetchTrailer(int movieId) => movieApiProvider.fetchTrailer(movieId);
  }