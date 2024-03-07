import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../utils/email_validator.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const path = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();

  bool isObsecure = true;

  void _handleLogin() {
    if (!formKey.currentState!.validate()) return;
  }

  void _toggleObsecure() {
    setState(() {
      isObsecure = !isObsecure;
    });
  }

  void _handleNavigateRegister() {
    context.pushNamed(RegisterScreen.path);
  }

  @override
  void dispose() {
    inputEmail.dispose();
    inputPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleLogin),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(AppLocalizations.of(context)!.textLoginDescription),
            const SizedBox(height: 16),
            TextFormField(
              controller: inputEmail,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.textEmail,
                hintText: AppLocalizations.of(context)!.textEmail,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.textRequired;
                }

                if (!checkValidEmail(value)) {
                  return AppLocalizations.of(context)!.textInvalidEmail;
                }

                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: inputPassword,
              obscureText: isObsecure,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.textPassword,
                hintText: AppLocalizations.of(context)!.textPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                      isObsecure ? Icons.visibility : Icons.visibility_off),
                  onPressed: _toggleObsecure,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.textRequired;
                }

                if (value.length < 8) {
                  return AppLocalizations.of(context)!.textInvalidPassword;
                }

                return null;
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _handleLogin,
              child: Text(AppLocalizations.of(context)!.titleLogin),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 4,
              children: [
                Text(AppLocalizations.of(context)!.textDontHaveAccount),
                GestureDetector(
                  onTap: _handleNavigateRegister,
                  child: Text(
                    AppLocalizations.of(context)!.titleRegister,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
