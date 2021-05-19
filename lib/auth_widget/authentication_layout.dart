import 'dart:io';

import 'package:clarity/ui_helpers/styles.dart';
import 'package:clarity/ui_helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auth_buttons/auth_buttons.dart';

class AuthenticationLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final String mainButtonTitle;
  final Widget form;
  final bool showTermsText;
  final void Function() onMainButtonTapped;
  final void Function() onCreateAccountTapped;
  final void Function() onForgotPassword;
  final void Function() onBackPressed;
  final void Function() onSignInWithApple;
  final void Function() onSignInWithGoogle;
  final String validationMessage;
  final bool busy;

  const AuthenticationLayout({
    Key key,
    this.title,
    this.subtitle,
    this.mainButtonTitle,
    this.form,
    this.onMainButtonTapped,
    this.onCreateAccountTapped,
    this.onForgotPassword,
    this.onBackPressed,
    this.onSignInWithApple,
    this.onSignInWithGoogle,
    this.validationMessage,
    this.showTermsText = false,
    this.busy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView(
        children: [
          if (onBackPressed == null) verticalSpaceLarge,
          if (onBackPressed != null) verticalSpaceRegular,
          if (onBackPressed != null)
            IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: onBackPressed,
            ),
          Text(
            title,
            style: TextStyle(fontSize: 34),
          ),
          verticalSpaceSmall,
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: screenWidthPercentage(context, percentage: 0.7),
              child: Text(
                subtitle,
                style: ktsMediumGreyBodyText,
              ),
            ),
          ),
          verticalSpaceRegular,
          form,
          verticalSpaceRegular,
          if (onForgotPassword != null)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: onForgotPassword,
                  child: Text(
                    'Forget Password?',
                    style: ktsMediumGreyBodyText.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          verticalSpaceRegular,
          if (validationMessage != null)
            Text(
              validationMessage,
              style: TextStyle(
                color: Colors.red,
                fontSize: kBodyTextSize,
              ),
            ),
          if (validationMessage != null) verticalSpaceRegular,
          GestureDetector(
            onTap: onMainButtonTapped,
            child: Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kcPrimaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: busy
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Text(
                      mainButtonTitle,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
            ),
          ),
          verticalSpaceRegular,
          if (onCreateAccountTapped != null)
            GestureDetector(
              onTap: onCreateAccountTapped,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  horizontalSpaceTiny,
                  Text(
                    'Create an account',
                    style: TextStyle(
                      color: kcPrimaryColor,
                    ),
                  )
                ],
              ),
            ),
          if (showTermsText)
            Text(
              'By signing up you agree to our terms, conditions and privacy policy.',
              style: ktsMediumGreyBodyText,
              textAlign: TextAlign.center,
            ),
          verticalSpaceRegular,
          Align(
              alignment: Alignment.center,
              child: Text(
                'Or',
                style: ktsMediumGreyBodyText,
              )),
          verticalSpaceRegular,
          if (Platform.isIOS)
            AppleAuthButton(
              onPressed: onSignInWithApple ?? () {},
              style: const AuthButtonStyle(
                buttonType: AuthButtonType.secondary,
                iconType: AuthIconType.outlined,
                borderRadius: 8,
                iconSize: 24.0,
                splashColor: Palette.secondaryBackground,
                buttonColor: Palette.appBackgroundColor,
              ),
            ),
          verticalSpaceRegular,
          GoogleAuthButton(
            onPressed: onSignInWithGoogle ?? () {},
            style: const AuthButtonStyle(
              buttonType: AuthButtonType.secondary,
              iconType: AuthIconType.outlined,
              borderRadius: 8,
              iconSize: 24.0,
              splashColor: Palette.appBackgroundColor,
              buttonColor: Palette.secondaryBackground,
              padding: EdgeInsets.all(10),
              textStyle: TextStyle(color: Colors.black),
              height: 56,
              iconBackground: Palette.appBackgroundColor,
              width: 100,
            ),
          )
        ],
      ),
    );
  }
}
