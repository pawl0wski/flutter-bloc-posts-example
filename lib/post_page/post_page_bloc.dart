import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PostEvent {}

class PostPageAddPost extends PostEvent {
  late String author;
  late String content;

  PostPageAddPost(this.author, this.content);
}

class PostPageDeletePost extends PostEvent {}

class PostPageBloc extends Bloc<PostEvent, List<Map<String, String>>> {
  PostPageBloc() : super([]) {
    on<PostPageAddPost>((PostPageAddPost event, emit) {
      state.add({"author": event.author, "content": event.content});
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
