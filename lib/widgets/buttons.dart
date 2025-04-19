import 'package:flutter/material.dart';
import '../core/app_managers/color_manager.dart';

class CostumeButtons extends StatefulWidget {
  final String labelText;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final bool isEnabled;
  final String btnType;

  const CostumeButtons.common({
    super.key,
    required this.labelText,
    this.onPressed,
    this.onLongPressed,
    required this.isEnabled,
    this.btnType = "common",
  });

  const CostumeButtons.positive({
    super.key,
    required this.labelText,
    this.onPressed,
    this.onLongPressed,
    required this.isEnabled,
    this.btnType = "positive",
  });

  const CostumeButtons.negative({
    super.key,
    required this.labelText,
    this.onPressed,
    this.onLongPressed,
    required this.isEnabled,
    this.btnType = "negative",
  });

  const CostumeButtons.blueBorder({
    super.key,
    required this.labelText,
    this.onPressed,
    this.onLongPressed,
    required this.isEnabled,
    this.btnType = "blueBorder",
  });

  @override
  State<CostumeButtons> createState() => _CostumeButtonsState();
}

class _CostumeButtonsState extends State<CostumeButtons> {
  @override
  Widget build(BuildContext context) {
    if (widget.btnType == "blueBorder") {
      return _buildBlueBorderButton();
    }

    // Default button styles
    return _buildFilledButton();
  }

  Widget _buildBlueBorderButton() {
    return OutlinedButton(
      onPressed: widget.isEnabled ? widget.onPressed : null,
      onLongPress: widget.isEnabled ? widget.onLongPressed : null,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.blue, width: 2.0),
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        widget.labelText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildFilledButton() {
    Color foregroundColor;
    Color backgroundColor;

    switch (widget.btnType) {
      case "positive":
        foregroundColor = ColorManager.positiveButtonForegroundColor;
        backgroundColor = ColorManager.positiveButtonBackgroundColor;
        break;
      case "negative":
        foregroundColor = ColorManager.negativeButtonForegroundColor;
        backgroundColor = ColorManager.negativeButtonBackgroundColor;
        break;
      default:
        foregroundColor = ColorManager.commonButtonForegroundColor;
        backgroundColor = ColorManager.commonButtonBackgroundColor;
    }

    return FilledButton(
      onPressed: widget.isEnabled ? widget.onPressed : null,
      onLongPress: widget.isEnabled ? widget.onLongPressed : null,
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        widget.labelText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: widget.isEnabled ? foregroundColor : null,
        ),
      ),
    );
  }
}
