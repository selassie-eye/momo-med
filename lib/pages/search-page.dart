import 'package:flutter/material.dart';

import './result-details.dart';

import '../model/venue.dart';

class SearchPage extends StatefulWidget {
  final Function update;
  final Function search;
  SearchPage(this.update, this.search);

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _SearchPageState();
    }
}

class _SearchPageState extends State<SearchPage> {
  bool isSearching;
  bool searchSubmitted;
  IconButton sendIcon;
  IconButton searchIcon;
  PopupMenuButton advSearchButton;
  Widget searchTitle;
  Widget searchBody;
  String query;

  List<Venue> results;

  @override
    void initState() {
      super.initState();
      isSearching = false;
      searchSubmitted = false;
      searchIcon = _buildSearchIcon();
      advSearchButton = new PopupMenuButton<String>(
        onSelected: (String value) => Navigator.pushNamed(context, value),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: '/adv-search',
            child: Text('Advanced Search')
      ),],);
      sendIcon = IconButton(
        icon: Icon(Icons.arrow_forward),
        onPressed: () {
          print('Submitted');
          widget.update(query: query);
          setState(() { searchSubmitted = true; });
          _buildSearchPage();
        },
      );
      searchTitle = Text('Search');
      searchBody = Center(child: Text('No results'));
      results = [];
    }

  IconButton _buildSearchIcon() {
    return isSearching?
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () => _closeSearchBox(),
      ) :
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () => _openSearchBox(),
      );
  }

  void _openSearchBox() {
    setState(() {
      isSearching = true;
      searchTitle = Container(
        padding: EdgeInsets.all(10.0),
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
            icon: Icon(Icons.search), labelText: 'Search',
          ),
          style: TextStyle(color: Colors.white),
          // IOS bug: onSubmitted does not trigger when the "done" button is pressed on the keyboard
          onSubmitted: (val) {
            print('Submitted');
            widget.update(query: val);
            setState(() { searchSubmitted = true; });
            _buildSearchPage();
          },
          onChanged: (val) { setState(() { query = val; }); },
        )
      );
      searchIcon = _buildSearchIcon();      
    });
  }

  void _closeSearchBox() {
    setState(() {
      isSearching = false;
      searchTitle = Text('Search');
      searchIcon = _buildSearchIcon();      
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: searchTitle,
      actions: <Widget>[
        sendIcon,
        searchIcon,
        advSearchButton,  
      ],
    );
  }

  FutureBuilder _buildResultsFuture() {
    print('Future called!');
    return FutureBuilder(
      future: widget.search(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none: return Center(child: Text('No results:ConnectionState.none'),);
          case ConnectionState.waiting: return Center(child: Text('Loading...'),);
          case ConnectionState.done:
            results = snapshot.data;
            return _buildResultsList();
          default: return Center(child: Text('No results:ConnectionState.default'),);
        }
      }
    );
  }

    Column _buildResultTile(BuildContext context, int index) {
    return Column(children: <Widget>[
      ListTile(
        leading: Icon(Icons.healing),
        title: results[index].name != '' ? Text(results[index].name) : Text('null'),
        onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => ResultDetails(results[index]))),
      ),
      Divider()
    ],);
  }

  Widget _buildResultsList() {
    return results.length > 0 ? ListView.builder(
      itemBuilder: _buildResultTile,
      itemCount: results.length,
    ) : Center(child: Text('No results!'));
  }

  void _buildSearchPage() {
    print('Build search called');
    if(searchSubmitted) {
      print('Search submitted');
      setState(() { 
        searchBody = _buildResultsFuture(); 
        searchSubmitted = false;
      });
    } else setState(() { 
        print('Search not submitted');
        searchBody = _buildResultsList(); 
      });
  }


  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: _buildAppBar(),
        body: searchBody
      );
    }
}