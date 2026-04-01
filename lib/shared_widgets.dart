import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'tools_screen.dart';
import 'convert_screen.dart';
import 'ai_screen.dart';
import 'settings_screen.dart';

void showAppSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

class Header extends StatelessWidget {
  const Header({super.key});

  static const String _logoUrl =
      'http://localhost:3845/assets/f72ceeb7ef5538161cd50326368d200f7b1f9161.png';
  static const String _profileUrl =
      'http://localhost:3845/assets/66ac359747809d364ee8aac5e6a98f9d72da572b.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 0.63),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Image.network(
                  _logoUrl,
                  width: 20,
                  height: 20,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.description,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(_profileUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    _profileUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const ColoredBox(
                      color: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: Color(0xFF64748B)),
                onPressed: () {
                  showAppSnackBar(context, 'Pencarian global segera hadir.');
                },
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF1E3A8A)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'AD',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Color(0xFF64748B),
                    ),
                    onPressed: () {
                      showAppSnackBar(context, 'Tidak ada notifikasi baru.');
                    },
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  final int activeIndex;

  const BottomNav({super.key, this.activeIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black, width: 0.63)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            label: 'Home',
            icon: Icons.home_filled,
            isActive: activeIndex == 0,
            onTap: () {
              if (activeIndex != 0) {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const HomeScreen(),
                    transitionDuration: Duration.zero,
                  ),
                );
              }
            },
          ),
          _NavItem(
            label: 'Tools',
            icon: Icons.build_outlined,
            isActive: activeIndex == 1,
            onTap: () {
              if (activeIndex != 1) {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const ToolsScreen(),
                    transitionDuration: Duration.zero,
                  ),
                );
              }
            },
          ),
          _NavItem(
            label: 'Convert',
            icon: Icons.transform,
            isActive: activeIndex == 2,
            onTap: () {
              if (activeIndex != 2) {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const ConvertScreen(),
                    transitionDuration: Duration.zero,
                  ),
                );
              }
            },
          ),
          _NavItem(
            label: 'AI',
            icon: Icons.auto_awesome,
            isActive: activeIndex == 3,
            onTap: () {
              if (activeIndex != 3) {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const AIScreen(),
                    transitionDuration: Duration.zero,
                  ),
                );
              }
            },
          ),
          _NavItem(
            label: 'Settings',
            icon: Icons.settings_outlined,
            isActive: activeIndex == 4,
            onTap: () {
              if (activeIndex != 4) {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const SettingsScreen(),
                    transitionDuration: Duration.zero,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback? onTap;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFFEFF6FF) : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: isActive
                    ? const Color(0xFF1E3A8A)
                    : const Color(0xFF94A3B8),
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? const Color(0xFF1E3A8A)
                    : const Color(0xFF94A3B8),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
