import 'package:chat_app_elision/pages/home_page.dart';
import 'package:chat_app_elision/repositories/authentication_repository.dart';
import 'package:chat_app_elision/repositories/chat_repository.dart';
import 'package:chat_app_elision/repositories/storage_repository.dart';
import 'package:chat_app_elision/repositories/user_data_repository.dart';
import 'package:chat_app_elision/utils/shared_objects.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/attachments/attachments_bloc.dart';
import 'blocs/authentication/bloc.dart';
import 'blocs/chats/chat_bloc.dart';
import 'blocs/chats/chat_event.dart';
import 'blocs/config/config_bloc.dart';
import 'blocs/config/config_state.dart';
import 'blocs/contacts/contacts_bloc.dart';
import 'blocs/home/home_bloc.dart';
import 'config/constants.dart';
import 'config/themes.dart';
import 'pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  //create instances of the repositories to supply them to the app
  final AuthenticationRepository authRepository = AuthenticationRepository();
  final UserDataRepository userDataRepository = UserDataRepository();
  final StorageRepository storageRepository = StorageRepository();
  final ChatRepository chatRepository = ChatRepository();
  SharedObjects.prefs = await CachedSharedPreferences.getInstance();
  Constants.cacheDirPath = (await getTemporaryDirectory()).path;
  Constants.downloadsDirPath =
      (await DownloadsPathProvider.downloadsDirectory).path;
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
            authenticationRepository: authRepository,
            userDataRepository: userDataRepository,
            storageRepository: storageRepository)
          ..add(AppLaunched()),
      ),
      BlocProvider<ContactsBloc>(
        create: (context) => ContactsBloc(
            userDataRepository: userDataRepository,
            chatRepository: chatRepository),
      ),
      BlocProvider<ChatBloc>(
        create: (context) => ChatBloc(
            userDataRepository: userDataRepository,
            storageRepository: storageRepository,
            chatRepository: chatRepository),
      ),
      BlocProvider<AttachmentsBloc>(
        create: (context) => AttachmentsBloc(chatRepository: chatRepository),
      ),
      BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(chatRepository: chatRepository),
      ),
      BlocProvider<ConfigBloc>(
        create: (context) => ConfigBloc(
            storageRepository: storageRepository,
            userDataRepository: userDataRepository),
      )
    ],
    child: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeData theme;
  Key key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(builder: (context, state) {
      if (state is UnConfigState) {
        theme = SharedObjects.prefs.getBool(Constants.configDarkMode)
            ? Themes.dark
            : Themes.light;
      }
      if (state is RestartedAppState) {
        key = UniqueKey();
      }
      if (state is ConfigChangeState && state.key == Constants.configDarkMode) {
        theme = state.value ? Themes.dark : Themes.light;
      }
      return MaterialApp(
        title: 'Chat App',
        theme: theme,
        key: key,
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is UnAuthenticated) {
              return RegisterPage();
            } else if (state is ProfileUpdated) {
              if (SharedObjects.prefs.getBool(Constants.configMessagePaging))
                BlocProvider.of<ChatBloc>(context).add(FetchChatListEvent());
              return HomePage();
            } else {
              return RegisterPage();
            }
          },
        ),
      );
    });
  }
}
