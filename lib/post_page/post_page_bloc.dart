import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PostEvent {}

class PostPageAddPost extends PostEvent {}

class PostPageDeletePost extends PostEvent {}

class PostPageBloc extends Bloc<PostEvent, List<Map<String, String>>> {
  PostPageBloc() : super([]) {
    on<PostPageAddPost>((event, emit) {
      state.add({"author": "John", "content": "Hello, world!"});
      emit(state.toList());
    });

    on<PostPageDeletePost>((event, emit) {
      if (state.isNotEmpty) {
        state.remove(state.last);
        emit(state.toList());
      }
    });
  }
}
