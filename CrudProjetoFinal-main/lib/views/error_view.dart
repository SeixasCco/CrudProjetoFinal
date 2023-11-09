import 'package:flutter/material.dart';
import '../constants/consts.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  ErrorView({required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.GenericFailure),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              SizedBox(height: 24),
              Text(
                AppStrings.GenericFailure,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                message,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              if (onRetry != null)
                ElevatedButton(
                  onPressed: onRetry,
                  child: Text(AppStrings.TryAgain),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
