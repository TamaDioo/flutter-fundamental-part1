import 'package:belanja/models/item.dart';
import 'package:belanja/pages/home_page.dart';
import 'package:belanja/pages/item_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return HomePage();
        },
        routes: <GoRoute>[
          GoRoute(
            path: 'item',
            name: 'item',
            builder: (BuildContext context, GoRouterState state) {
              // Mengambil data Item yang dikirim melalui 'extra'
              final item = state.extra as Item;
              return ItemPage(item: item);
            },
          ),
        ],
      ),
    ],
  );
}
