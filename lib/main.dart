import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'PostLikesModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Instagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Instagram Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numOfSavedPosts = 0;

  void changeNumOfSavedPosts(bool increment) {
    setState(() {
      increment ? numOfSavedPosts++ : numOfSavedPosts--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Header(savedPosts: numOfSavedPosts)),
      body: Container(
        color: Colors.white,
        child: Expanded(
          child: ListView(children: [
            // Stories row
            Container(
              decoration: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 0.2, color: Colors.grey)),
              width: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(5),
                scrollDirection: Axis.horizontal,
                child: Row(children: const [
                  Story(),
                  Story(userName: 'user1'),
                  Story(userName: 'user2'),
                  Story(userName: 'user3'),
                  Story(userName: 'user4'),
                  Story(userName: 'user5'),
                  Story(userName: 'user6'),
                  Story(userName: 'user7'),
                  Story(userName: 'user8'),
                  Story(userName: 'user9'),
                  Story(userName: 'user10')
                ]),
              ),
            ),

            // Posts
            Post(changeNumOfSavedPosts: changeNumOfSavedPosts),
            Post(
                imageAsset: 'images/default.png',
                changeNumOfSavedPosts: changeNumOfSavedPosts),
            Post(
                imageAsset: 'images/download.png',
                changeNumOfSavedPosts: changeNumOfSavedPosts),
            Post(
                imageAsset: 'images/download1.png',
                changeNumOfSavedPosts: changeNumOfSavedPosts),
            Post(
                imageAsset: 'images/download2.png',
                changeNumOfSavedPosts: changeNumOfSavedPosts),
            Post(
                imageAsset: 'images/download3.png',
                changeNumOfSavedPosts: changeNumOfSavedPosts)
          ]),
        ),
      ),

      // Bottom row with command buttons
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(width: 0.2, color: Colors.grey))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomButton(iconData: Icons.home_filled),
              BottomButton(iconData: Icons.search),
              BottomButton(iconData: Icons.add_box_outlined),
              BottomButton(iconData: Icons.favorite_border),
              BottomButton(iconData: Icons.account_circle_rounded)
            ],
          )
          ),
        ),
      );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key, required this.savedPosts}) : super(key: key);

  final int savedPosts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Instagram'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.bookmark_rounded),
              Text(': $savedPosts')],
          )
        ],
      ),
    );
  }
}

class Story extends StatelessWidget {
  const Story({Key? key, this.userName = 'default_user'}) : super(key: key);

  final String userName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: const EdgeInsets.symmetric(horizontal: 1),
      // margin: EdgeInsets.zero,
      width: 80,
      height: 90,
      child: Column(children: [
        const Expanded(
            child: FittedBox(
          fit: BoxFit.fill,
          child: Icon(Icons.account_circle_outlined),
        )),
        Text(userName,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: TextStyle(fontSize: 12))
      ]),
    );
  }
}

class LikeButton extends StatelessWidget {
  const LikeButton(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.favorite_border, size: 30),
      onPressed: () => Provider.of<PostLikesModel>(context, listen: false).increment(),
    );
  }
}

class SaveButton extends StatefulWidget {
  const SaveButton({Key? key, required this.changeNumOfSavedPosts}) : super(key: key);

  final Function changeNumOfSavedPosts;

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool isSaved = false;

  IconData getIcon() {
    return isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_outlined;
  }

  void changeSaveStatus() {
    setState(() {
      isSaved = !isSaved;
      widget.changeNumOfSavedPosts(isSaved);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(getIcon(), size: 30),
      onPressed: changeSaveStatus,
    );
  }
}

class Post extends StatefulWidget {
  const Post(
      {Key? key,
      required this.changeNumOfSavedPosts,
      this.imageAsset = 'images/default.png'})
      : super(key: key);

  final String imageAsset;
  final Function changeNumOfSavedPosts;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  int numOfLikes = 1000;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => PostLikesModel(numOfLikes),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(userName: 'user_name'),
          Container(
            decoration: const BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(width: 0.2, color: Colors.grey),
              ),
            ),
            constraints: const BoxConstraints(maxHeight: 450),
            child: Image(
              image: AssetImage(widget.imageAsset),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              LikeButton(),
              Expanded(child: SizedBox()),
              SaveButton(changeNumOfSavedPosts: widget.changeNumOfSavedPosts),
            ]),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Description(numOfLikes: numOfLikes))
        ]));
  }
}

class PostHeader extends StatelessWidget {
  const PostHeader(
      {Key? key,
      required this.userName,
      this.userIcon = Icons.account_circle_rounded,
      this.location = ''})
      : super(key: key);

  final IconData userIcon;
  final String userName;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 0.1,
          icon: Icon(
            userIcon,
            size: 30,
          ),
          onPressed: () {},
        ),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              userName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              location,
              style: TextStyle(fontSize: 12),
            )
          ]),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 0.1,
          icon: const Icon(
            Icons.more_vert_outlined,
            size: 30,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class Description extends StatelessWidget {
  const Description(
      {Key? key,
      required this.numOfLikes,
      this.userName = 'user_name',
      this.text =
          'some very large text that can be displayed in a maximum of two lines. Otherwise it will be trimmed with three dots at the end.'})
      : super(key: key);

  final int numOfLikes;
  final String userName;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<PostLikesModel>(
          builder: (context, model, child) {
            return Text('Нравится: ${model.numOfLines}',
                style: TextStyle(fontWeight: FontWeight.bold));
          }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                        text: userName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: text),
                  ])),
        ),
      ],
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({Key? key, required this.iconData})
      : super(key: key);

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      padding: EdgeInsets.zero,
      splashRadius: 0.1,
      icon: Icon(iconData),
      onPressed: () {},
    );
  }
}
