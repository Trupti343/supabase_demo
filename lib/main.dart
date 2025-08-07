import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://mvxjzbquhnvgmqvmktiw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im12eGp6YnF1aG52Z21xdm1rdGl3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI0OTM1ODMsImV4cCI6MjA2ODA2OTU4M30.EDyOevIj795qKqggiRPSD2O6XrI4OWpy6qLzU5RsFAs',
  );

  // await Supabase.initialize(
  //   url: 'https://lskonjvrsagnpprmuesx.supabase.co',
  //   anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxza29uanZyc2FnbnBwcm11ZXN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM5NDIzMjYsImV4cCI6MjA2OTUxODMyNn0.zsFERFws7ZzAGi7eY4dCr7zbaIv8a2S3ZtWTmEI78JU',
  // );

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

