part of '../pdf_tool_screens.dart';

class PdfToWordScreen extends StatefulWidget {
  const PdfToWordScreen({super.key});

  @override
  State<PdfToWordScreen> createState() => _PdfToWordScreenState();
}

class _PdfToWordScreenState extends State<PdfToWordScreen>
    with _PdfPickerMixin<PdfToWordScreen> {
  String? _selectedFileName;
  bool _preserveLayout = true;

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
  }

  void _convertPdfToWord() {
    if (_selectedFileName == null) {
      showAppSnackBar(context, 'Pilih file PDF terlebih dahulu.');
      return;
    }

    final mode = _preserveLayout ? 'Preserve layout' : 'Editable first';
    showAppSnackBar(context, 'Konversi PDF ke Word dimulai ($mode).');
  }

  @override
  Widget build(BuildContext context) {
    return _PdfToolScreen(
      title: 'PDF to Word',
      subtitle: 'Convert PDF to editable Word format',
      steps: const [
        'Select your PDF',
        'Choose conversion mode',
        'Click Convert',
      ],
      uploadTitle: _selectedFileName ?? 'Select your PDF file',
      uploadSubtitle: uploadSubtitleOf(_selectedFileName),
      uploadedFiles: uploadedFilesOf(_selectedFileName),
      onUploadTap: _pickPdfFile,
      extraContent: _ToolCard(
        title: 'Conversion Options',
        child: Row(
          children: [
            Expanded(
              child: Text(
                _preserveLayout
                    ? 'Preserve original layout'
                    : 'Prioritize editable text',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF334155),
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Switch(
              value: _preserveLayout,
              onChanged: (value) {
                setState(() {
                  _preserveLayout = value;
                });
              },
            ),
          ],
        ),
      ),
      actionLabel: 'Convert to Word',
      onActionTap: _convertPdfToWord,
      isActionEnabled: _selectedFileName != null,
    );
  }
}
