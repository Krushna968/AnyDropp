import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../providers/app_state.dart';
import '../widgets/settings_section_header.dart';
import '../widgets/settings_tile.dart';

class SettingsProfileScreen extends StatefulWidget {
  final AppState appState;
  final VoidCallback? onBack;

  const SettingsProfileScreen({
    super.key,
    required this.appState,
    this.onBack,
  });

  @override
  State<SettingsProfileScreen> createState() => _SettingsProfileScreenState();
}

class _SettingsProfileScreenState extends State<SettingsProfileScreen> {
  bool _personalizedRatings = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () {
            if (widget.onBack != null) {
              widget.onBack!();
            } else if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 40),
        children: [
          // Dark Gold Member Card (matching settings page.jpeg)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1E1E2A),
                    Color(0xFF14141E),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF2E2E3E), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // User Details Row
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        // Golden Initial Avatar
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFF1DEB4),
                            border: Border.all(color: AppTheme.goldAccent.withValues(alpha: 0.6), width: 1.5),
                          ),
                          child: const Center(
                            child: Text(
                              'J',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF755B27),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Janmesh',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: const [
                                  Text(
                                    'Edit profile',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: Color(0xFFB0B0C0),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.play_arrow,
                                    size: 10,
                                    color: Color(0xFFB0B0C0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider inside dark card
                  Divider(
                    height: 1,
                    thickness: 0.8,
                    color: Colors.white.withOpacity(0.1),
                  ),

                  // Gold Member Badge Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF2A2315),
                              ),
                              child: const Icon(
                                Icons.workspace_premium,
                                color: AppTheme.goldAccent,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Gold member',
                              style: TextStyle(
                                color: AppTheme.goldAccent,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF332B1C),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.goldAccent.withOpacity(0.4), width: 0.8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'saved ₹42',
                                style: TextStyle(
                                  color: AppTheme.goldAccentLight,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.chevron_right,
                                size: 14,
                                color: AppTheme.goldAccentLight,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Two Quick Action Cards (Zomato Money & Your Coupons)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppTheme.borderLight),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.account_balance_wallet_outlined, size: 20, color: AppTheme.textSecondary),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Zomato Money',
                              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '₹0',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.vegGreen),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppTheme.borderLight),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.confirmation_num_outlined, size: 20, color: AppTheme.textSecondary),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Your coupons',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 1. Your Preferences Section
          const SettingsSectionHeader(title: 'Your preferences'),
          _buildCard([
            SettingsTile(
              icon: Icons.eco,
              iconColor: AppTheme.vegGreen,
              title: 'Veg Mode',
              trailingText: widget.appState.isVegOnly ? 'On' : 'Off',
              onTap: () => widget.appState.toggleVegMode(),
            ),
            SettingsTile(
              icon: Icons.star_border_rounded,
              title: 'Show personalised ratings',
              trailingWidget: SizedBox(
                height: 24,
                width: 36,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    value: _personalizedRatings,
                    onChanged: (val) {
                      setState(() {
                        _personalizedRatings = val;
                      });
                    },
                    activeColor: AppTheme.primaryRed,
                  ),
                ),
              ),
            ),
            const SettingsTile(
              icon: Icons.wb_sunny_outlined,
              title: 'Appearance',
              trailingText: 'Light',
            ),
            const SettingsTile(
              icon: Icons.payment_outlined,
              title: 'Payment methods',
              showDivider: false,
            ),
          ]),

          // 2. Food Delivery Section
          const SettingsSectionHeader(title: 'Food delivery'),
          _buildCard([
            const SettingsTile(icon: Icons.receipt_long_outlined, title: 'Your orders'),
            const SettingsTile(icon: Icons.menu_book_outlined, title: 'Address book'),
            const SettingsTile(icon: Icons.bookmark_border, title: 'Your collections'),
            const SettingsTile(icon: Icons.tune, title: 'Manage recommendations'),
            const SettingsTile(icon: Icons.train_outlined, title: 'Order on train'),
            const SettingsTile(icon: Icons.support_agent_outlined, title: 'Online ordering help'),
            const SettingsTile(icon: Icons.visibility_off_outlined, title: 'Hidden Restaurants'),
            const SettingsTile(icon: Icons.campaign_outlined, title: 'Hear from restaurants', showDivider: false),
          ]),

          // 3. Dining & Experiences Section
          const SettingsSectionHeader(title: 'Dining & experiences'),
          _buildCard([
            const SettingsTile(icon: Icons.history, title: 'Your dining transactions'),
            const SettingsTile(icon: Icons.monetization_on_outlined, title: 'Your DineCoins'),
            const SettingsTile(icon: Icons.card_giftcard_outlined, title: 'Your dining rewards'),
            const SettingsTile(icon: Icons.table_restaurant_outlined, title: 'Your bookings'),
            const SettingsTile(icon: Icons.bookmark_border, title: 'Your collections'),
            const SettingsTile(icon: Icons.help_outline, title: 'Dining help', showDivider: false),
          ]),

          // 4. Gift Cards & Credits Section
          const SettingsSectionHeader(title: 'Gift cards & credits'),
          _buildCard([
            const SettingsTile(icon: Icons.card_membership_outlined, title: 'Buy Gift Card'),
            const SettingsTile(icon: Icons.redeem_outlined, title: 'Claim Gift Card'),
            const SettingsTile(icon: Icons.account_balance_outlined, title: 'Zomato Credits', showDivider: false),
          ]),

          // 5. Zomato For Enterprise Section
          const SettingsSectionHeader(title: 'Zomato For Enterprise'),
          _buildCard([
            const SettingsTile(icon: Icons.business_outlined, title: 'For employers'),
            const SettingsTile(icon: Icons.badge_outlined, title: 'For employees', showDivider: false),
          ]),

          // 6. Feeding India Section
          const SettingsSectionHeader(title: 'Feeding India'),
          _buildCard([
            const SettingsTile(icon: Icons.restaurant_outlined, title: 'Your impact'),
            // Banner callout: Serve your first meal today!
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: const [
                  Icon(Icons.favorite, color: AppTheme.primaryRed, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Serve your first meal today!',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SettingsTile(icon: Icons.receipt_outlined, title: 'Get donation receipt', showDivider: false),
          ]),

          // 7. Memberships & Rewards Section
          const SettingsSectionHeader(title: 'Memberships & rewards'),
          _buildCard([
            const SettingsTile(icon: Icons.discount_outlined, title: 'Redeem Gold coupon'),
            const SettingsTile(icon: Icons.sports_cricket_outlined, title: 'ZPL Hand Cricket', showDivider: false),
          ]),

          // 8. More Section
          const SettingsSectionHeader(title: 'More'),
          _buildCard([
            const SettingsTile(icon: Icons.thumb_up_alt_outlined, title: 'Your feedback'),
            const SettingsTile(icon: Icons.info_outline, title: 'About'),
            const SettingsTile(icon: Icons.rate_review_outlined, title: 'Send feedback'),
            const SettingsTile(icon: Icons.warning_amber_rounded, title: 'Report a safety emergency'),
            const SettingsTile(icon: Icons.accessibility_new_outlined, title: 'Accessibility'),
            const SettingsTile(icon: Icons.settings_outlined, title: 'Settings'),
            const SettingsTile(
              icon: Icons.power_settings_new,
              title: 'Log out',
              showDivider: false,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderLight),
      ),
      child: Column(children: children),
    );
  }
}
