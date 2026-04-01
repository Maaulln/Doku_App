import 'package:flutter/material.dart';
import 'shared_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> _menus = const [
    'Profile',
    'Notifications',
    'Security',
    'Appearance',
    'Billing',
  ];

  int _activeMenuIndex = 0;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: 'Adam');
    _lastNameController = TextEditingController(text: 'Kosong');
    _emailController = TextEditingController(text: 'alex@company.com');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      bottomNavigationBar: const BottomNav(activeIndex: 4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              const SizedBox(height: 16),
              const _TitleSection(),
              const SizedBox(height: 24),
              _SettingsMenuCard(
                menus: _menus,
                activeMenuIndex: _activeMenuIndex,
                onMenuTap: (index) {
                  setState(() {
                    _activeMenuIndex = index;
                  });
                  showAppSnackBar(context, 'Menu ${_menus[index]} dibuka.');
                },
              ),
              const SizedBox(height: 24),
              _ProfileSettingsCard(
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                emailController: _emailController,
                onChangeAvatar: () {
                  showAppSnackBar(context, 'Pilih avatar baru.');
                },
                onSave: () {
                  showAppSnackBar(
                    context,
                    'Perubahan profil berhasil disimpan.',
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E293B),
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Manage your account and preferences',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF94A3B8),
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsMenuCard extends StatelessWidget {
  const _SettingsMenuCard({
    required this.menus,
    required this.activeMenuIndex,
    required this.onMenuTap,
  });

  final List<String> menus;
  final int activeMenuIndex;
  final ValueChanged<int> onMenuTap;

  IconData _iconFor(String title) {
    switch (title) {
      case 'Profile':
        return Icons.person_outline;
      case 'Notifications':
        return Icons.notifications_none;
      case 'Security':
        return Icons.security;
      case 'Appearance':
        return Icons.palette_outlined;
      case 'Billing':
        return Icons.receipt_long_outlined;
      default:
        return Icons.settings_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: List.generate(
            menus.length,
            (index) => _SettingsMenuItem(
              icon: _iconFor(menus[index]),
              title: menus[index],
              active: index == activeMenuIndex,
              isLast: index == menus.length - 1,
              onTap: () => onMenuTap(index),
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsMenuItem extends StatelessWidget {
  const _SettingsMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.active = false,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool active;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.vertical(
          top: const Radius.circular(16),
          bottom: isLast ? const Radius.circular(16) : Radius.zero,
        ),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: active ? const Color(0xFFEFF6FF) : Colors.white,
            border: isLast
                ? null
                : const Border(
                    bottom: BorderSide(color: Color(0xFFF1F5F9), width: 0.8),
                  ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: active
                    ? const Color(0xFF1E3A8A)
                    : const Color(0xFF64748B),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: active
                        ? const Color(0xFF1E3A8A)
                        : const Color(0xFF64748B),
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF94A3B8),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileSettingsCard extends StatelessWidget {
  const _ProfileSettingsCard({
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.onChangeAvatar,
    required this.onSave,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final VoidCallback onChangeAvatar;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 0.8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E293B),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF1E3A8A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'AD',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Adam',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E293B),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextButton(
                      onPressed: onChangeAvatar,
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: const Text(
                        'Change avatar',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3B82F6),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            _Field(label: 'First Name', controller: firstNameController),
            const SizedBox(height: 14),
            _Field(label: 'Last Name', controller: lastNameController),
            const SizedBox(height: 14),
            _Field(label: 'Email', controller: emailController),
            const SizedBox(height: 24),
            SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3A8A),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          height: 42,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(14),
          ),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
            ),
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1E293B),
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }
}
