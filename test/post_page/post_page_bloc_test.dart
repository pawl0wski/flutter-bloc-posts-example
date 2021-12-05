import 'package:bloc_posts/post_page/post_page_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("PostPageBloc test", () {
    late PostPageBloc postPageBloc;

    setUp(() {
      postPageBloc = PostPageBloc();
    });

    blocTest<PostPageBloc, PostPageState>("Insert test post",
        build: () => postPageBloc,
        act: (PostPageBloc bloc) =>
            bloc.add(PostPageAddPost("TestUser", "TestMessage")),
        expect: () => [
              PostPageData(const [
                {"author": "TestUser", "content": "TestMessage"}
              ])
            ]);

    blocTest<PostPageBloc, PostPageState>("Insert empty post",
        build: () => postPageBloc,
        act: (PostPageBloc bloc) => bloc.add(PostPageAddPost("TestUser", "")),
        expect: () => [isA<PostPageError>()]);

    blocTest<PostPageBloc, PostPageState>("Delete post",
        build: () => postPageBloc,
        act: (PostPageBloc bloc) => {
              bloc.add(PostPageAddPost("TestUser", "TestMessage")),
              bloc.add(PostPageDeletePost())
            },
        expect: () => [
              PostPageData(const []),
            ]);

    tearDown(() {
      postPageBloc.close();
    });
  });
}
