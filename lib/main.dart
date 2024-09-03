import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:open_diary_app/amplify_outputs.dart';
import 'package:open_diary_app/models/ModelProvider.dart';
import 'package:open_diary_app/open_diary_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await _configureAmplify();
    runApp(const MainApp());
  } on AmplifyException catch (e) {
    runApp(ErrorWidget(e));
  }
}

Future<void> _configureAmplify() async {
  await Amplify.addPlugins([
    AmplifyAuthCognito(),
    AmplifyAPI(
      options: APIPluginOptions(
        modelProvider: ModelProvider.instance,
      ),
    ),
    AmplifyStorageS3(),
  ]);
  await Amplify.configure(amplifyConfig);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Open Diary App'),
            actions: [
              IconButton(
                onPressed: () {
                  Amplify.Auth.signOut();
                },
                icon: const Icon(Icons.exit_to_app),
              )
            ],
          ),
          body: const OpenDiaryAppHomePage(),
        ),
      ),
    );
  }
}
