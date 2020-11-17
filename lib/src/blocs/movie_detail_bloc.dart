
import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../models/trailer_model.dart';
import '../resorses/repository.dart';
import 'bloc_base.dart';
import 'package:inject/inject.dart';

class MovieDetailBloc extends BlocBase{
  final Repository _repository;
  PublishSubject<int> _movieId;
  BehaviorSubject<Future<TrailerModel>> _trailers;

  @provide
  MovieDetailBloc(this._repository);

  Function(int) get fetchTrailersById => _movieId.sink.add;
  Stream<Future<TrailerModel>> get movieTrailers => _trailers.stream;

  init(){
    _movieId = PublishSubject<int>();
    _trailers = BehaviorSubject<Future<TrailerModel>>();
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
  }

  
  @override
  dispose() async {
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
          (Future<TrailerModel> trailer, int id, int index) {
        print(index);
        trailer = _repository.fetchTrailer(id);
        return trailer;
      },
    );
  }
}