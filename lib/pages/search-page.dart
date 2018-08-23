import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _SearchPageState();
    }
}

class _SearchPageState extends State<SearchPage> {
  bool isSearching;
  IconButton searchIcon;
  PopupMenuButton advSearchButton;
  Widget searchTitle;
  String query;

  @override
    void initState() {
      super.initState();
      isSearching = false;
      searchIcon = _buildSearchIcon();
      advSearchButton = new PopupMenuButton<String>(
        onSelected: (String value) => Navigator.pushNamed(context, value),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: '/adv-search',
            child: Text('Advanced Search')
      ),],);
      searchTitle = Text('Search');
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
      searchTitle = TextField(
        decoration: InputDecoration(icon: Icon(Icons.search), labelText: 'Search'),
        style: TextStyle(color: Colors.white),
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
        searchIcon,
        advSearchButton,  
      ],
    );
  }

  Widget _buildSearchPage() {
    return Container();
  }


  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: _buildAppBar(),
        body: _buildSearchPage()
      );
    }
}