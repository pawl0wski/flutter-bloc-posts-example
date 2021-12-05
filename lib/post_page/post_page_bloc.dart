import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events

abstract class PostEvent {}

class PostPageAddPost extends PostEvent {
  late String author;
  late String content;

  PostPageAddPost(this.author, this.content);
}

class PostPageDeletePost extends PostEvent {}

// States
abstract class PostPageState extends Equatable {}

class PostPageData extends PostPageState {
  List<Map<String, String>> posts = [];
  PostPageData(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostPageError extends PostPageState {
  String message;
  PostPageError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc

class PostPageBloc extends Bloc<PostEvent, PostPageState> {
  List<Map<String, String>> posts = [];

  PostPageBloc() : super(PostPageData([])) {
    on<PostPageAddPost>((PostPageAddPost event, emit) {
      if (event.content.isEmpty) {
        emit(PostPageError("You need to provide post content."));
      } else {
        posts.add({"author": event.author, "content": event.content});
        emit(PostPageData(posts));
      }
    });

    on<PostPageDeletePost>((event, emit) {
      if (posts.isNotEmpty) {
        posts.remove(posts.last);
        emit(PostPageData(posts));
      }
    });
  }
}
