import 'package:bloc_posts/post_page/post_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostPageBloc(),
      child: PostPageView(),
    );
  }
}

class PostPageView extends StatelessWidget {
  const PostPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Posts"),
        ),
        body: BlocBuilder<PostPageBloc, List<Map<String, String>>>(
          builder: (BuildContext context, List<Map<String, String>> posts) {
            List<Widget> listOfPosts = [];

            posts.forEach((post) {
              listOfPosts.add(Card(
                child: ListTile(
                  title: Text(post["author"]!),
                  subtitle: Text(post["content"]!),
                ),
              ));
            });

            return ListView(
              children: listOfPosts,
            );
          },
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () =>
                  BlocProvider.of<PostPageBloc>(context).add(PostPageAddPost()),
              tooltip: 'Add post',
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              onPressed: () => BlocProvider.of<PostPageBloc>(context)
                  .add(PostPageDeletePost()),
              tooltip: 'Delete post',
              child: const Icon(Icons.remove),
            ),
          ],
        ));
  }
}
