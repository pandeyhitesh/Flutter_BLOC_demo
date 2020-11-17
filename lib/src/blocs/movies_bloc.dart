import '../resorses/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import 'package:inject/inject.dart';
import 'bloc_base.dart';


class MoviesBloc extends BlocBase{
  final Repository _repository;
  PublishSubject<ItemModel> _movies_fetcher;

  @provide
  MoviesBloc(this._repository);

  init(){
    _movies_fetcher = PublishSubject<ItemModel>();
  }

  Stream<ItemModel> get allMovies =>_movies_fetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _movies_fetcher.sink.add(itemModel);
  }

  @override
  dispose(){
    _movies_fetcher.close();
  }
}
