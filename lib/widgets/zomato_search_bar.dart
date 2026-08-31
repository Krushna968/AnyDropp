import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class ZomatoSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final bool isVegOnly;
  final VoidCallback onToggleVeg;

  const ZomatoSearchBar({
    super.key,
    required this.onChanged,
    required this.isVegOnly,
    required this.onToggleVeg,
  });

  @override
  State<ZomatoSearchBar> createState() => _ZomatoSearchBarState();
}

class _ZomatoSearchBarState extends State<ZomatoSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _hintKeywords = ['curries', 'biryani', 'pizza', 'shawarma', 'cake', 'burger'];
  int _currentHintIndex = 0;
  Timer? _hintTimer;

  @override
  void initState() {
    super.initState();
    _hintTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted && _controller.text.isEmpty) {
        setState(() {
          _currentHintIndex = (_currentHintIndex + 1) % _hintKeywords.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _hintTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const Icon(
            Icons.search,
            color: AppTheme.primaryRed,
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                if (_controller.text.isEmpty)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 0.4),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      'Search "${_hintKeywords[_currentHintIndex]}"',
                      key: ValueKey<String>(_hintKeywords[_currentHintIndex]),
                      style: TextStyle(
                        color: AppTheme.textMuted.withValues(alpha: 0.85),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                TextField(
                  controller: _controller,
                  onChanged: widget.onChanged,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
          if (_controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _controller.clear();
                widget.onChanged('');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Icon(Icons.close, size: 18, color: AppTheme.textMuted),
              ),
            ),
          const Icon(
            Icons.mic_none_rounded,
            color: AppTheme.primaryRed,
            size: 22,
          ),
          const SizedBox(width: 10),
          Container(
            height: 24,
            width: 1,
            color: AppTheme.dividerColor,
          ),
          const SizedBox(width: 8),
          // Veg Switch Row
          InkWell(
            onTap: widget.onToggleVeg,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'VEG',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: widget.isVegOnly ? AppTheme.vegGreen : AppTheme.textMuted,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.isVegOnly ? AppTheme.vegGreen : AppTheme.textMuted,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.isVegOnly ? AppTheme.vegGreen : AppTheme.textMuted,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  SizedBox(
                    height: 16,
                    width: 30,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Switch(
                        value: widget.isVegOnly,
                        onChanged: (_) {
                          HapticFeedback.selectionClick();
                          widget.onToggleVeg();
                        },
                        activeThumbColor: AppTheme.vegGreen,
                        activeTrackColor: AppTheme.vegGreen.withValues(alpha: 0.3),
                        inactiveThumbColor: Colors.grey.shade400,
                        inactiveTrackColor: Colors.grey.shade200,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
