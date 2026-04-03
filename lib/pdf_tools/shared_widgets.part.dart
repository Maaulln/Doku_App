part of '../pdf_tool_screens.dart';

class _PdfToolScreen extends StatelessWidget {
  const _PdfToolScreen({
    required this.title,
    required this.subtitle,
    required this.steps,
    required this.onUploadTap,
    this.uploadTitle = 'Select your PDF files',
    this.uploadSubtitle = 'Drag & drop or browse files from your computer',
    this.uploadedFiles = const [],
    this.extraContent,
    this.actionLabel,
    this.onActionTap,
    this.isActionEnabled = true,
  });

  final String title;
  final String subtitle;
  final List<String> steps;
  final VoidCallback onUploadTap;
  final String uploadTitle;
  final String uploadSubtitle;
  final List<String> uploadedFiles;
  final Widget? extraContent;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final bool isActionEnabled;

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
                        children: [
                          const _UploadIcon(),
                          const SizedBox(height: 16),
                          Text(
                            uploadTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                              fontFamily: 'Inter',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            uploadSubtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF94A3B8),
                              height: 1.5,
                              fontFamily: 'Inter',
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
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
              if (uploadedFiles.isNotEmpty) ...[
                const SizedBox(height: 16),
                _UploadedFilesCard(uploadedFiles: uploadedFiles),
              ],
              if (extraContent != null) ...[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: extraContent!,
                ),
              ],
              if (actionLabel != null && onActionTap != null) ...[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isActionEnabled ? onActionTap : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFF2563EB),
                        disabledBackgroundColor: const Color(0xFFBFDBFE),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        actionLabel!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _UploadedFilesCard extends StatelessWidget {
  const _UploadedFilesCard({required this.uploadedFiles});

  final List<String> uploadedFiles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Uploaded file${uploadedFiles.length > 1 ? 's' : ''}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF334155),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 10),
            ...uploadedFiles.map(
              (fileName) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 16,
                      color: Color(0xFFEF4444),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        fileName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF475569),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderFilesCard extends StatelessWidget {
  const _OrderFilesCard({
    required this.files,
    required this.onMoveUp,
    required this.onMoveDown,
  });

  final List<String> files;
  final ValueChanged<int> onMoveUp;
  final ValueChanged<int> onMoveDown;

  @override
  Widget build(BuildContext context) {
    return _ToolCard(
      title: 'File Order',
      child: Column(
        children: List.generate(
          files.length,
          (index) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${index + 1}. ${files[index]}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF334155),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: index == 0 ? null : () => onMoveUp(index),
                  icon: const Icon(Icons.keyboard_arrow_up, size: 18),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: index == files.length - 1
                      ? null
                      : () => onMoveDown(index),
                  icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  const _ToolCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
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
