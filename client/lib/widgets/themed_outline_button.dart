import 'package:flutter/material.dart';

class ThemedOutlinedButton extends OutlinedButton {
  const ThemedOutlinedButton({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    required Widget child,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          child: child,
        );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsets.symmetric(horizontal: 16),
      const EdgeInsets.symmetric(horizontal: 8),
      const EdgeInsets.symmetric(horizontal: 4),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );

    return OutlinedButton.styleFrom(
      primary: colorScheme.primary,
      onSurface: colorScheme.onSurface,
      backgroundColor: Colors.transparent,
      shadowColor: theme.shadowColor,
      elevation: 0,
      textStyle: theme.textTheme.button,
      padding: scaledPadding,
      minimumSize: const Size(64, 36),
      maximumSize: Size.infinite,
      side: BorderSide(
        color: colorScheme.primary,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      enabledMouseCursor: SystemMouseCursors.click,
      disabledMouseCursor: SystemMouseCursors.forbidden,
      visualDensity: theme.visualDensity,
      tapTargetSize: theme.materialTapTargetSize,
      animationDuration: kThemeChangeDuration,
      enableFeedback: true,
      alignment: Alignment.center,
      splashFactory: InkRipple.splashFactory,
    );
  }
}
