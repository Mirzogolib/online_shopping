import 'package:flutter/material.dart';
import 'package:online_shopping/providers/auth_provider.dart';
import 'package:online_shopping/tools/constants.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Your orders'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.payment),
              title: Text('Orders'),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(Constants.orderRoute)),
          Divider(),
          ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Products'),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(Constants.userProductsRoute)),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          )

          // Navigator.of(context)
          // .pushReplacementNamed(Constants.userProductsRoute)),
        ],
      ),
    );
  }
}
