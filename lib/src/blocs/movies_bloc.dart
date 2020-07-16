import '../resorses/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import 'package:observable/observable.dart';


class MoviesBloc{
  final _repository = Repository();
  final _movies_fetcher = PublishSubject<ItemModel>();

  Stream<ItemModel> get allMovies =>_movies_fetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _movies_fetcher.sink.add(itemModel);
  }

  dispose(){
    _movies_fetcher.close();
  }
}

final bloc = MoviesBloc();