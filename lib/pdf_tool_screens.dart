import 'package:flutter/material.dart';

import 'shared_widgets.dart';

class MergePdfScreen extends StatelessWidget {
  const MergePdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PdfToolScreen(
      title: 'Merge PDF',
      subtitle: 'Combine multiple PDF files into a single document',
      steps: const ['Select your PDF files', 'Drag to reorder', 'Click Merge'],
      onUploadTap: () {
        showAppSnackBar(context, 'Pilih file PDF untuk digabungkan.');
      },
    );
  }
}

class SplitPdfScreen extends StatelessWidget {
  const SplitPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PdfToolScreen(
      title: 'Split PDF',
      subtitle: 'Split a PDF into individual pages or custom ranges',
      steps: const ['Select your PDF', 'Choose pages or range', 'Click Split'],
      onUploadTap: () {
        showAppSnackBar(context, 'Pilih file PDF untuk dipisah.');
      },
    );
  }
}

class CompressPdfScreen extends StatelessWidget {
  const CompressPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PdfToolScreen(
      title: 'Compress PDF',
      subtitle: 'Reduce the file size of your PDF documents',
      steps: const [
        'Select your PDF',
        'Choose compression level',
        'Download compressed file',
      ],
      onUploadTap: () {
        showAppSnackBar(context, 'Pilih file PDF untuk dikompresi.');
      },
    );
  }
}

class RotatePdfScreen extends StatelessWidget {
  const RotatePdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PdfToolScreen(
      title: 'Rotate PDF',
      subtitle: 'Rotate PDF pages to the correct orientation',
      steps: const [
        'Select your PDF',
        'Choose pages to rotate',
        'Select rotation angle',
      ],
      onUploadTap: () {
        showAppSnackBar(context, 'Pilih file PDF untuk dirotasi.');
      },
    );
  }
}

class _PdfToolScreen extends StatelessWidget {
  const _PdfToolScreen({
    required this.title,
    required this.subtitle,
    required this.steps,
    required this.onUploadTap,
  });

  final String title;
  final String subtitle;
  final List<String> steps;
  final VoidCallback onUploadTap;

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
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: const Color(0xFF64748B),
                  ),
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E293B),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF94A3B8),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: List.generate(
                    steps.length,
                    (index) =>
                        _StepItem(number: index + 1, label: steps[index]),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: onUploadTap,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 32,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFCBD5E1),
                          width: 1.8,
                        ),
                      ),
                      child: Column(
                        children: const [
                          _UploadIcon(),
                          SizedBox(height: 16),
                          Text(
                            'Select your PDF files',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Drag & drop or browse files from your computer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF94A3B8),
                              height: 1.5,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Files are processed locally in your browser',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFCBD5E1),
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  const _StepItem({required this.number, required this.label});

  final int number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Color(0xFFEFF6FF),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$number',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3B82F6),
              fontFamily: 'Inter',
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}

class _UploadIcon extends StatelessWidget {
  const _UploadIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(Icons.folder_open, color: Color(0xFF3B82F6), size: 32),
    );
  }
}
