import 'package:flutter/material.dart';

import '../search.dart';

class SearchBar extends StatefulWidget {
  final String title;
  SearchBar(this.title);

  Function buildBar;

  @override
    State<StatefulWidget> createState() {
      _SearchBarState state = _SearchBarState();
      buildBar = state.buildBar;
      return _SearchBarState();
    }
}

class _SearchBarState extends State<SearchBar> {
  Widget searchTitle;
  IconButton searchIcon;
  PopupMenuButton advSearchButton;
  String query;
  List<String> autocompleteResults;
  List<Widget> stackList;
  ListView resultsDisplay;

  bool isSearching;

  @override
    void initState() {
      super.initState();
      searchTitle = new Text(widget.title);
      searchIcon = new IconButton(
        icon: Icon(Icons.search),
        onPressed: _displaySearchBox,
      );
      advSearchButton = new PopupMenuButton<String>(
        onSelected: (String value) => Navigator.pushNamed(context, value),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: '/adv-search',
            child: Text('Advanced Search')
          )
        ],
      );
      query = '';
      autocompleteResults = [];
      isSearching = false;
      stackList = [
        Center(child: Text('Search for something!'),),
        _buildACResults()
      ];
      resultsDisplay = null;
    }

  IconButton _buildSearchIcon() {
    return isSearching?
      new IconButton(
        icon: Icon(Icons.close),
        onPressed: _closeSearchBox,
      ) :
      new IconButton(
        icon: Icon(Icons.search),
        onPressed: _displaySearchBox,
      );
  }

  void _updateSearchIcon() {
    setState(() { searchIcon = _buildSearchIcon(); });
  }

  Widget _buildACResults() {
    return ListView.builder(
      itemCount: autocompleteResults.length,
      itemBuilder: (BuildContext context, int index) {
        return autocompleteResults.length > 0 ? Column(children: <Widget>[
          ListTile(
            leading: Icon(Icons.local_hospital),
            title: Text(autocompleteResults[index])
            //  onTap: 
          ),
          Divider()
        ],) : null;
      },
    );
  }

  void _updateACResults(List<String> nextACResults) {
    setState(() { autocompleteResults = nextACResults; });
  }  
  void _handleQueryUpdate() {
    List<String> services = Locations.list;
    List<String> nextACResults = [];

    if(query.isNotEmpty) {
      services.forEach((String s) { if(s.toLowerCase().contains(query.toLowerCase())) { 
        nextACResults.add(s);
      } });
    }
    _updateACResults(nextACResults);
  }

  void _displaySearchBox() {
    setState(() {
      isSearching = true;
      searchTitle = new TextField(
        decoration: InputDecoration(labelText: 'Search'),
        onChanged: (String value) { setState(() {
          query = value;
          _handleQueryUpdate();
        });}
      );      
    });
    _updateSearchIcon();
  }

  void _closeSearchBox() {
    setState(() {
      isSearching = false;
      searchTitle = new Text(widget.title);      
    });
    _updateSearchIcon();
  }

  AppBar buildBar() {
    return AppBar(
      title: searchTitle,
      actions: <Widget>[
        searchIcon,
        advSearchButton
      ],
    );
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: searchTitle,
          actions: <Widget>[
            searchIcon,
            advSearchButton
          ],
        ),
        body: Stack(children: stackList)
      );
  }
}