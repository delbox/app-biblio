import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:tracking_app/common/routes.dart';
import 'package:tracking_app/providers/providers.dart';
import 'package:tracking_app/theme/app_theme.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterLogs.initLogs(
    logLevelsEnabled: [
      LogLevel.INFO,
      LogLevel.ERROR,
    ],
    timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
    directoryStructure: DirectoryStructure.FOR_DATE,
    logTypesEnabled: ["device", "network", "errors"],
    logFileExtension: LogFileExtension.LOG,
    logsWriteDirectoryName: "TranckingLogs",
    logsExportDirectoryName: "TranckingLogs/Exported",
    debugFileOperations: true,
    isDebuggable: true,
  );




  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AlmacenProvider()),
        ChangeNotifierProvider(create: (_) => ViajeProvider()),
      ],
      child: const TrackingApp(),
    ),
  );
}




class TrackingApp extends StatelessWidget {
  const TrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bibliotecas Tracking',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/loading',
      routes: AppRoutes.routes,
    );
  }
}
