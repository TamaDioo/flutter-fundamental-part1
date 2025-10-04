import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  debugPaintSizeEnabled = false; // Set to true for visual layout.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: buildHomePage('Dio Andika Pradana M. T. - 2341720098'),
    );
  }

  Widget buildHomePage(String title) {
    const titleText = Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        'Lapis Legit',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          fontSize: 25,
        ),
      ),
    );

    const subTitle = Text(
      'Kue Lapis Legit, atau Spekkoek, adalah kue basah premium warisan kuliner Belanda-Indonesia. '
      'Dikenal karena teksturnya yang padat, lembap, dan kaya akan aroma rempah seperti kayu manis, cengkeh, dan pala. ',
      textAlign: TextAlign.center,
      style: TextStyle(fontFamily: 'Georgia', fontSize: 18),
    );

    // #docregion ratings, stars
    final stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.deepPurple[500]),
        Icon(Icons.star, color: Colors.deepPurple[500]),
        Icon(Icons.star, color: Colors.deepPurple[500]),
        Icon(Icons.star, color: Colors.deepPurple[500]),
        const Icon(Icons.star, color: Color.fromRGBO(0, 0, 0, 1)),
      ],
    );
    // #enddocregion stars

    final ratings = Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          stars,
          const Text(
            '245 Reviews',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
    // #enddocregion ratings

    // #docregion icon-list
    const descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 16,
      height: 2,
    );

    // DefaultTextStyle.merge() allows you to create a default text
    // style that is inherited by its child and all subsequent children.
    final iconList = DefaultTextStyle.merge(
      style: descTextStyle,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(Icons.kitchen, color: Colors.deepPurple[500]),
                const Text('PREP:'),
                const Text('30 min'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.timer, color: Colors.deepPurple[500]),
                const Text('COOK:'),
                const Text('2 hr'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.restaurant, color: Colors.deepPurple[500]),
                const Text('FEEDS:'),
                const Text('7-10'),
              ],
            ),
          ],
        ),
      ),
    );
    // #enddocregion icon-list

    // #docregion left-column
    final leftColumn = Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: ListView(children: [titleText, subTitle, ratings, iconList]),
    );
    // #enddocregion left-column

    final mainImage = Image.asset('images/lapis_legit.jpg', fit: BoxFit.cover);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      // #docregion body
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 40, 0, 30),
          height: 600,
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: leftColumn),
                Expanded(flex: 2, child: mainImage),
              ],
            ),
          ),
        ),
      ),
      // #enddocregion body
    );
  }
}
