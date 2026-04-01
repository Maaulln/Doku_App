import 'package:flutter/material.dart';
import 'shared_widgets.dart';

class ConvertScreen extends StatefulWidget {
  const ConvertScreen({super.key});

  @override
  State<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  final List<_FormatOption> _formats = const [
    _FormatOption(
      title: 'Word',
      extension: '.docx',
      icon: Icons.description_outlined,
      iconColor: Color(0xFF3B82F6),
      iconBg: Color(0xFFEFF6FF),
    ),
    _FormatOption(
      title: 'Excel',
      extension: '.xlsx',
      icon: Icons.table_chart_outlined,
      iconColor: Color(0xFF16A34A),
      iconBg: Color(0xFFF0FDF4),
    ),
    _FormatOption(
      title: 'PowerPoint',
      extension: '.pptx',
      icon: Icons.slideshow_outlined,
      iconColor: Color(0xFFEA580C),
      iconBg: Color(0xFFFFF7ED),
    ),
    _FormatOption(
      title: 'JPG Image',
      extension: '.jpg',
      icon: Icons.image_outlined,
      iconColor: Color(0xFF7C3AED),
      iconBg: Color(0xFFF5F3FF),
    ),
    _FormatOption(
      title: 'HTML',
      extension: '.html',
      icon: Icons.code_outlined,
      iconColor: Color(0xFF0891B2),
      iconBg: Color(0xFFECFEFF),
    ),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      bottomNavigationBar: const BottomNav(activeIndex: 2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              const SizedBox(height: 16),
              const _TitleSection(),
              const SizedBox(height: 24),
              _FormatSection(
                formats: _formats,
                selectedIndex: _selectedIndex,
                onSelect: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  showAppSnackBar(
                    context,
                    'Format dipilih: ${_formats[index].title} ${_formats[index].extension}',
                  );
                },
              ),
              const SizedBox(height: 24),
              _UploadSection(
                onUploadTap: () {
                  final format = _formats[_selectedIndex];
                  showAppSnackBar(
                    context,
                    'Pilih file PDF untuk dikonversi ke ${format.title}.',
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
            'Convert PDF',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E293B),
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Convert your PDF documents to various formats',
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

class _FormatSection extends StatelessWidget {
  const _FormatSection({
    required this.formats,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<_FormatOption> formats;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Output Format',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E293B),
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.95,
            ),
            itemCount: formats.length,
            itemBuilder: (context, index) {
              final item = formats[index];
              return _FormatCard(
                title: item.title,
                extension: item.extension,
                icon: item.icon,
                iconColor: item.iconColor,
                iconBg: item.iconBg,
                selected: index == selectedIndex,
                onTap: () => onSelect(index),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FormatCard extends StatelessWidget {
  const _FormatCard({
    required this.title,
    required this.extension,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.onTap,
    this.selected = false,
  });

  final String title;
  final String extension;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFEFF6FF) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? const Color(0xFF3B82F6)
                  : const Color(0xFFE2E8F0),
              width: 1.6,
            ),
            boxShadow: selected
                ? const [
                    BoxShadow(
                      color: Color(0x1A3B82F6),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E293B),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                extension,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF94A3B8),
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

class _UploadSection extends StatelessWidget {
  const _UploadSection({required this.onUploadTap});

  final VoidCallback onUploadTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onUploadTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFCBD5E1), width: 1.2),
            ),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.cloud_upload_outlined,
                    color: Color(0xFF3B82F6),
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                    children: [
                      TextSpan(text: 'Drop your PDF here or '),
                      TextSpan(
                        text: 'browse',
                        style: TextStyle(color: Color(0xFF3B82F6)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Supports PDF files up to 100MB',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF94A3B8),
                    fontFamily: 'Inter',
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

class _FormatOption {
  const _FormatOption({
    required this.title,
    required this.extension,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  final String title;
  final String extension;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
}
