import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/features/auth/presentation/screens/login/service/login_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
