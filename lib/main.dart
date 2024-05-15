import 'package:flutter/material.dart';
import 'package:lobbying/data/provider/authentication_provider.dart';
import 'package:lobbying/data/provider/tracking_provider.dart';
import 'package:lobbying/my_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider<TrackingProvider>(
          create: (_) => TrackingProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
