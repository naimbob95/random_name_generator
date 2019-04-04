import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
 
    
    return MaterialApp
    (
      title: 'Random Name Generator',
      home: RandomWords(),
      theme: ThemeData(
        primaryColor: Colors.white,
      )
   
    );

    } 
  }

  class RandomWords extends StatefulWidget
  {
    @override
    RandomWordsState createState() => new RandomWordsState();

  }

  class RandomWordsState extends State<RandomWords>
  { 
    final Set<WordPair> _saved = new Set<WordPair>();
    final List<WordPair> _suggestions = <WordPair>[];
    final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

    void _pushSaved()
    {
        Navigator.of(context).push
        (
          new MaterialPageRoute<void>(
            builder: (BuildContext context)
            {
              final Iterable<ListTile> tiles = _saved.map( 
                (WordPair pair)
                {
                  return new ListTile( 
                    title : new Text( 
                      pair.asPascalCase,
                      style: _biggerFont,
                    ),
                  );
                },
              );
            final List<Widget> divided = ListTile
            .divideTiles( 
              context: context,
              tiles: tiles,
            )
            .toList();

            return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Saved Suggestions",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    "https://images.sharefaith.com/images/3/1424204225486_19/img_mouseover3.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body:new ListView(children: divided),
  
      ),
    );
            },
          ),
        );
    }

    @override
    Widget build(BuildContext)
    {
      return Scaffold( 
        appBar: AppBar( 
        title: const Text('Random Name Generator'),
          elevation: 0.0,


         actions: <Widget>
         [
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),

         ],
        
        ),
    
      body: _buildSuggestions(),
      );
      
    }

    Widget _buildSuggestions()
    {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context,i)
      {
        if (i.isOdd) return Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length)
        {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return _buildRow(_suggestions[index]);
      });  
    }

    Widget _buildRow(WordPair pair)
    {
      final bool alreadySaved = _saved.contains(pair);
      return ListTile(
      title: Text(
       pair.asPascalCase,
       style: _biggerFont,
      ),
      trailing: new Icon( 
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: ()
      {
        setState(()
         {
           if(alreadySaved)
           {
             _saved.remove(pair);
           } else 
           {
             _saved.add(pair);

           }
        });
      }
    );
  }  
}



  



