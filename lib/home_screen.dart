import 'package:flutter/material.dart';

import 'ai_screen.dart';
import 'convert_screen.dart';
import 'pdf_tool_screens.dart';
import 'shared_widgets.dart';
import 'tools_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      bottomNavigationBar: const BottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Header(),
              SizedBox(height: 24),
              _WelcomeSection(),
              SizedBox(height: 24),
              _QuickToolsSection(),
              SizedBox(height: 24),
              _AIBannerSection(),
              SizedBox(height: 24),
              _RecentActivitySection(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Welcome back, Adam',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E293B),
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Manage and transform your documents with ease',
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

class _QuickToolsSection extends StatelessWidget {
  const _QuickToolsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Quick Tools',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E293B),
                  fontFamily: 'Inter',
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ToolsScreen()),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'See all',
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
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 112 / 100, // Matching the design roughly
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _ToolCard(
                label: 'Merge',
                icon: Icons.call_merge,
                bgColor: Color(0xFFEFF6FF),
                iconColor: Color(0xFF3B82F6),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const MergePdfScreen()),
                  );
                },
              ),
              _ToolCard(
                label: 'Split',
                icon: Icons.call_split,
                bgColor: Color(0xFFF5F3FF),
                iconColor: Color(0xFF8B5CF6),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SplitPdfScreen()),
                  );
                },
              ),
              _ToolCard(
                label: 'Compress',
                icon: Icons.compress,
                bgColor: Color(0xFFECFDF5),
                iconColor: Color(0xFF10B981),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const CompressPdfScreen(),
                    ),
                  );
                },
              ),
              _ToolCard(
                label: 'Organize',
                icon: Icons.folder_open,
                bgColor: Color(0xFFFFFBEB),
                iconColor: Color(0xFFF59E0B),
                onTap: () {
                  showAppSnackBar(context, 'Fitur Organize sedang disiapkan.');
                },
              ),
              _ToolCard(
                label: 'Rotate',
                icon: Icons.rotate_right,
                bgColor: Color(0xFFFEF2F2),
                iconColor: Color(0xFFEF4444),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RotatePdfScreen()),
                  );
                },
              ),
              _ToolCard(
                label: 'Convert',
                icon: Icons.transform,
                bgColor: Color(0xFFECFEFF),
                iconColor: Color(0xFF06B6D4),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ConvertScreen()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _ToolCard({
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 0.63),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E293B),
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AIBannerSection extends StatelessWidget {
  const _AIBannerSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.forum_outlined, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'AI Document QnA',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Ask anything about your docs',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFBEDBFF),
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const AIScreen()));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Try it',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentActivitySection extends StatelessWidget {
  const _RecentActivitySection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E293B),
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          _ActivityItem(
            title: 'Q4_Report_2025.pdf',
            subtitle: '4.2 MB · 2 hours ago',
            status: 'Compressed',
            statusWidth: 82,
          ),
          const SizedBox(height: 12),
          _ActivityItem(
            title: 'Contract_Draft_v3.pdf',
            subtitle: '1.8 MB · 5 hours ago',
            status: 'Merged',
            statusWidth: 56,
          ),
          const SizedBox(height: 12),
          _ActivityItem(
            title: 'Presentation_Final.pdf',
            subtitle: '12.4 MB · Yesterday',
            status: 'Converted',
            statusWidth: 71,
          ),
          const SizedBox(height: 12),
          _ActivityItem(
            title: 'Invoice_March.pdf',
            subtitle: '0.8 MB · 2 days ago',
            status: 'Split',
            statusWidth: 40,
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final double statusWidth;

  const _ActivityItem({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 0.63),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.insert_drive_file_outlined,
              color: Color(0xFFEF4444),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E293B),
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF10B981),
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
