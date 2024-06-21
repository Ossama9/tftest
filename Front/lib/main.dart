import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:front/auth/login.dart';
import 'package:front/auth/register.dart';
import 'package:front/chat/screens/conversation_screen.dart';
import 'package:front/colocation/bloc/colocation_bloc.dart';
import 'package:front/colocation/colocation_members.dart';
import 'package:front/colocation/colocation_parameters.dart';
import 'package:front/colocation/colocation_tasklist_screen.dart';
import 'package:front/colocation/colocation_update.dart';
import 'package:front/colocation/create_colocation.dart';
import 'package:front/home_screen.dart';
import 'package:front/invitation/bloc/invitation_bloc.dart';
import 'package:front/invitation/invitation_create_page.dart';
import 'package:front/invitation/invitation_list_page.dart';
import 'package:front/profile/profile_screen.dart';
import 'package:front/reset-password/reset_password.dart';
import 'package:front/reset-password/reset_password_form.dart';
import 'package:front/shared.widget/bottom_navigation_bar.dart';
import 'package:front/task/add_new_task_screen.dart';
import 'package:front/task/bloc/task_bloc.dart';
import 'package:front/task/task_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InvitationBloc>(
          create: (context) => InvitationBloc(),
        ),
        BlocProvider<ColocationBloc>(
          create: (context) => ColocationBloc(),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Colobris',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const Scaffold(
                body: HomeScreen(),
                bottomNavigationBar: BottomNavigationBarWidget(null),
              ),
          '/create_colocation': (context) => const CreateColocationPage(),
          '/profile': (context) => const Scaffold(
                body: ProfileScreen(),
                bottomNavigationBar: BottomNavigationBarWidget(null),
              ),
          '/reset-password': (context) => const ResetPasswordScreen(),
          '/reset-password-form': (context) => ResetPasswordFormScreen(),
        },
        onGenerateRoute: (settings) {
          final routes = settings.arguments as Map<dynamic, dynamic>? ?? {};
          switch (settings.name) {
            case ColocationTasklistScreen.routeName:
              return MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: BlocProvider.of<ColocationBloc>(context),
                  child: ColocationTasklistScreen(
                    colocation: routes['colocation'],
                  ),
                ),
                settings: settings,
              );
            case '/invitations':
              return MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: BlocProvider.of<InvitationBloc>(context),
                  child: InvitationListPage(
                    invitations: routes['invitations'],
                  ),
                ),
                settings: settings,
              );
            case '/create_invitation':
              return MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: BlocProvider.of<InvitationBloc>(context),
                  child: InvitationCreatePage(
                    colocationId: routes['colocationId'],
                  ),
                ),
                settings: settings,
              );
            case AddNewTaskScreen.routeName:
              return MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: BlocProvider.of<TaskBloc>(context),
                  child: AddNewTaskScreen(
                    colocation: routes['colocation'],
                  ),
                ),
                settings: settings,
              );
            case '/colocation_manage':
              return MaterialPageRoute(
                builder: (context) => ColocationSettingsPage(
                  colocationId: routes['colocationId'],
                ),
              );
            case '/colocation_members':
              return MaterialPageRoute(
                builder: (context) => ColocationMembers(
                  users: routes['users'],
                ),
              );
            case '/colocation_update':
              return MaterialPageRoute(
                builder: (context) => ColocationUpdatePage(
                  colocationId: routes['colocationId'],
                ),
              );
            case '/task_detail':
              return MaterialPageRoute(
                builder: (context) => TaskDetailPage(
                  task: routes['task'],
                ),
              );
            case '/chat':
              return MaterialPageRoute(
                builder: (context) => ConversationScreen(
                  conversationId: routes['chatId'],
                ),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
