import 'package:flutter/material.dart';

import './tabs/services.dart';
import './tabs/favorites.dart';
import './tabs/profile.dart';
import './tabs/privacy.dart';
import './adv-search.dart';

import '../widgets/title.dart';
import '../search.dart';
import '../model/user.dart';

class MainMenu extends StatelessWidget {
  User user;
  MainMenu([this.user]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 4, child: Scaffold(
      /*  Pullout menu - not needed at this time
      ----------------------------------------------------------------
      drawer: Drawer(child: Column(children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text('Menu'),
        ),
        ListTile(
          title: Text('Advanced Search'),
          onTap: () => Navigator.pushNamed(context, '/adv-search')  
        ),
      ],),),
      ----------------------------------------------------------------
      */

      appBar: TitleBar('MoMo Medical').build(context, ['Services', 'Favorites', 'Profile', 'Privacy'], true),
      body: TabBarView(children: <Widget>[
        Services(Locations.list),
        Favorites(),
        Profile(user),
        Privacy()
      ])
    ),);
  }
}
