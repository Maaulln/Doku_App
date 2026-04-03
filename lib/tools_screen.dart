import 'package:flutter/material.dart';

import 'pdf_tool_screens.dart';
import 'shared_widgets.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  static final Map<String, WidgetBuilder> _toolRoutes = {
    'Merge PDF': (_) => const MergePdfScreen(),
    'Split PDF': (_) => const SplitPdfScreen(),
    'Compress PDF': (_) => const CompressPdfScreen(),
    'Rotate PDF': (_) => const RotatePdfScreen(),
    'PDF to Word': (_) => const PdfToWordScreen(),
    'Protect PDF': (_) => const ProtectPdfScreen(),
  };

  static const List<String> _categories = [
    'All',
    'Essential',
    'Edit',
    'Convert',
    'Security',
  ];

  static const List<_ToolItem> _allTools = [
    _ToolItem(
      title: 'Merge PDF',
      subtitle: 'Combine multiple PDFs into one document',
      tag: 'Essential',
      icon: Icons.call_merge,
      iconColor: Color(0xFF3B82F6),
      iconBgColor: Color(0xFFEFF6FF),
      category: 'Essential',
    ),
    _ToolItem(
      title: 'Split PDF',
      subtitle: 'Split PDF into multiple files',
      tag: 'Essential',
      icon: Icons.call_split,
      iconColor: Color(0xFF8B5CF6),
      iconBgColor: Color(0xFFF5F3FF),
      category: 'Essential',
    ),
    _ToolItem(
      title: 'Compress PDF',
      subtitle: 'Reduce file size without losing quality',
      tag: 'Essential',
      icon: Icons.compress,
      iconColor: Color(0xFF10B981),
      iconBgColor: Color(0xFFECFDF5),
      category: 'Essential',
    ),
    _ToolItem(
      title: 'Rotate PDF',
      subtitle: 'Rotate pages in any direction',
      tag: 'Edit',
      icon: Icons.rotate_right,
      iconColor: Color(0xFFEF4444),
      iconBgColor: Color(0xFFFEF2F2),
      category: 'Edit',
    ),
    _ToolItem(
      title: 'PDF to Word',
      subtitle: 'Convert PDF to editable Word format',
      tag: 'Convert',
      icon: Icons.description_outlined,
      iconColor: Color(0xFF2563EB),
      iconBgColor: Color(0xFFEFF6FF),
      category: 'Convert',
    ),
    _ToolItem(
      title: 'Protect PDF',
      subtitle: 'Add password protection to your PDF',
      tag: 'Security',
      icon: Icons.lock_outline,
      iconColor: Color(0xFF0F766E),
      iconBgColor: Color(0xFFECFEFF),
      category: 'Security',
    ),
  ];

  String _activeCategory = 'All';
  String _query = '';

  List<_ToolItem> get _filteredTools {
    final byCategory = _activeCategory == 'All'
        ? _allTools
        : _allTools.where((item) => item.category == _activeCategory).toList();

    if (_query.trim().isEmpty) {
      return byCategory;
    }

    final keyword = _query.toLowerCase();
    return byCategory
        .where(
          (item) =>
              item.title.toLowerCase().contains(keyword) ||
              item.subtitle.toLowerCase().contains(keyword) ||
              item.tag.toLowerCase().contains(keyword),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      bottomNavigationBar: const BottomNav(activeIndex: 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              const SizedBox(height: 24),
              const _HeaderSection(),
              const SizedBox(height: 24),
              _CategoriesSection(
                categories: _categories,
                activeCategory: _activeCategory,
                onCategoryTap: (category) {
                  setState(() {
                    _activeCategory = category;
                  });
                },
              ),
              const SizedBox(height: 16),
              _SearchSection(
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              _ToolsListSection(
                tools: _filteredTools,
                onToolTap: (tool) {
                  final routeBuilder = _toolRoutes[tool.title];
                  if (routeBuilder != null) {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: routeBuilder));
                  } else {
                    showAppSnackBar(context, '${tool.title} dipilih.');
                  }
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

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Tools',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E293B),
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Browse and use all available PDF tools',
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

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection({
    required this.categories,
    required this.activeCategory,
    required this.onCategoryTap,
  });

  final List<String> categories;
  final String activeCategory;
  final ValueChanged<String> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: categories
            .map(
              (category) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _CategoryChip(
                  label: category,
                  isActive: category == activeCategory,
                  onTap: () => onCategoryTap(category),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF1E3A8A) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: isActive
                ? null
                : Border.all(color: const Color(0xFFE2E8F0), width: 0.63),
            boxShadow: isActive
                ? const [
                    BoxShadow(
                      color: Color(0x331E3A8A),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.white : const Color(0xFF64748B),
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchSection extends StatelessWidget {
  const _SearchSection({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 0.63),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                onChanged: onChanged,
                decoration: const InputDecoration(
                  hintText: 'Search tools...',
                  hintStyle: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolsListSection extends StatelessWidget {
  const _ToolsListSection({required this.tools, required this.onToolTap});

  final List<_ToolItem> tools;
  final ValueChanged<_ToolItem> onToolTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: tools.isEmpty
          ? const _EmptyState()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: tools
                  .map(
                    (tool) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _ToolLargeCard(
                        tool: tool,
                        onTap: () => onToolTap(tool),
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 0.63),
      ),
      child: const Center(
        child: Text(
          'Tidak ada tool yang cocok dengan pencarian.',
          style: TextStyle(
            color: Color(0xFF64748B),
            fontSize: 14,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}

class _ToolLargeCard extends StatelessWidget {
  const _ToolLargeCard({required this.tool, required this.onTap});

  static const double _cardHeight = 210;

  final _ToolItem tool;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: _cardHeight,
          child: Container(
            padding: const EdgeInsets.all(24),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: tool.iconBgColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(tool.icon, color: tool.iconColor, size: 24),
                ),
                const SizedBox(height: 24),
                Text(
                  tool.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E293B),
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tool.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF94A3B8),
                    fontFamily: 'Inter',
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tool.tag,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ToolItem {
  const _ToolItem({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.category,
  });

  final String title;
  final String subtitle;
  final String tag;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String category;
}
