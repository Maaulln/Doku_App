part of '../pdf_tool_screens.dart';

class SplitPdfScreen extends StatefulWidget {
  const SplitPdfScreen({super.key});

  @override
  State<SplitPdfScreen> createState() => _SplitPdfScreenState();
}

class _SplitPdfScreenState extends State<SplitPdfScreen>
    with _PdfPickerMixin<SplitPdfScreen> {
  String? _selectedFileName;
  bool _splitPerPage = true;
  final TextEditingController _rangeController = TextEditingController();

  Future<void> _pickPdfFile() async {
    final selectedFiles = await pickPdfFileNames();

    if (!mounted) {
      return;
    }

    if (selectedFiles == null) {
      showCancelledSelection();
      return;
    }

    setState(() {
      _selectedFileName = selectedFiles.first;
    });

    showAppSnackBar(context, 'File terpilih: ${selectedFiles.first}');
  }

  void _splitPdf() {
    if (_selectedFileName == null) {
      showAppSnackBar(context, 'Pilih file PDF terlebih dahulu.');
      return;
    }

    if (!_splitPerPage && _rangeController.text.trim().isEmpty) {
      showAppSnackBar(context, 'Isi range halaman, contoh: 1-3,5,8-10.');
      return;
    }

    final mode = _splitPerPage
        ? 'per halaman'
        : 'range ${_rangeController.text.trim()}';
    showAppSnackBar(context, 'Memproses split PDF dengan mode $mode.');
  }

  @override
  void dispose() {
    _rangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActionEnabled =
        _selectedFileName != null &&
        (_splitPerPage || _rangeController.text.trim().isNotEmpty);

    return _PdfToolScreen(
      title: 'Split PDF',
      subtitle: 'Split a PDF into individual pages or custom ranges',
      steps: const ['Select your PDF', 'Choose pages or range', 'Click Split'],
      uploadTitle: _selectedFileName ?? 'Select your PDF file',
      uploadSubtitle: uploadSubtitleOf(_selectedFileName),
      uploadedFiles: uploadedFilesOf(_selectedFileName),
      onUploadTap: _pickPdfFile,
      extraContent: _ToolCard(
        title: 'Split Options',
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _splitPerPage ? 'Split each page' : 'Use page range',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF334155),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                Switch(
                  value: _splitPerPage,
                  onChanged: (value) {
                    setState(() {
                      _splitPerPage = value;
                    });
                  },
                ),
              ],
            ),
            if (!_splitPerPage) ...[
              const SizedBox(height: 10),
              TextField(
                controller: _rangeController,
                onChanged: (_) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Contoh: 1-3,5,8-10',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actionLabel: 'Split PDF',
      onActionTap: _splitPdf,
      isActionEnabled: isActionEnabled,
    );
  }
}
