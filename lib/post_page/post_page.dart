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

            var _formKey = GlobalKey<FormState>();

            return Column(children: [
              PostAddForm(formKey: _formKey),
              Expanded(
                  child: ListView(
                children: listOfPosts,
              )),
            ]);
          },
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => BlocProvider.of<PostPageBloc>(context)
                  .add(PostPageAddPost("John", "Hello")),
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

class PostAddForm extends StatelessWidget {
  const PostAddForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        decoration: InputDecoration(
            suffixIcon: IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.send),
          color: Theme.of(context).primaryColor,
        )),
      ),
    );
  }
}
