import 'package:flutter/material.dart';

enum Pages {
  featured,
  searchtest,
  cattest,
  search,
  favorites,
  privacy,
  profile,
  services,
  advsearch,
  auth,
  mainmenu,
  results,
  resultdetails,
}

class TestPage extends StatelessWidget {
  List<Pages> pageList;
  TestPage() { pageList = [
    Pages.featured,
    Pages.searchtest,
    Pages.cattest,
    Pages.search,
    Pages.favorites,
    Pages.privacy,
    Pages.profile,
    Pages.services,
    Pages.advsearch,
    Pages.auth,
    Pages.mainmenu,
    Pages.results,
    Pages.resultdetails
  ]; }

  String _parsePage(Pages page) {
    switch (page) {
      case Pages.featured: return '/featured';
      case Pages.searchtest: return '/search-test';
      case Pages.cattest: return '/categories-test';
      case Pages.search: return '/search';
      case Pages.favorites: return '/favorites';
      case Pages.privacy: return  '/privacy';
      case Pages.profile: return '/profile';
      case Pages.services: return '/services';
      case Pages.advsearch: return '/adv-search';
      case Pages.auth: return '/auth';
      case Pages.mainmenu: return '/main-menu';
      case Pages.results: return '/results';
      case Pages.resultdetails: return '/result-details';
      default: return '/';
    }
  }

  Widget _buildButtonList() {
    return ListView.builder(
      itemCount: pageList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(10.0),
          child: FlatButton(
            child: Text(_parsePage(pageList[index])),
            onPressed: () => Navigator.pushNamed(context, _parsePage(pageList[index])),
          ),
        );
      },
    );
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(title: Text('Test Page')),
        body: _buildButtonList()
      );
    }
}