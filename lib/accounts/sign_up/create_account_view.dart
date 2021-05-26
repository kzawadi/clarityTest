import 'package:clarity/accounts/sign_up/create_account_viewModel.dart';
import 'package:clarity/auth_widget/authentication_layout.dart';
import 'package:clarity/main.dart';
import 'package:clarity/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'create_account_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'fullName'),
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class CreateAccountView extends StatelessWidget with $CreateAccountView {
  CreateAccountView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateAccountViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Scaffold(
          backgroundColor: KColors.background,
          body: AuthenticationLayout(
            busy: model.isBusy,
            onMainButtonTapped: model.saveData,
            onBackPressed: model.navigateBack,
            validationMessage: model.validationMessage,
            title: 'Create Account',
            subtitle: 'Enter your name, email and password for sign up.',
            mainButtonTitle: 'SIGN UP',
            form: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Full Name'),
                  controller: fullNameController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                  controller: emailController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: passwordController,
                ),
              ],
            ),
            showTermsText: true,
          )),
      viewModelBuilder: () => CreateAccountViewModel(),
    );
  }
}
