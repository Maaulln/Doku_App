part of '../pdf_tool_screens.dart';

class CompressPdfScreen extends StatefulWidget {
  const CompressPdfScreen({super.key});

  @override
  State<CompressPdfScreen> createState() => _CompressPdfScreenState();
}

class _CompressPdfScreenState extends State<CompressPdfScreen>
    with _PdfPickerMixin<CompressPdfScreen> {
  String? _selectedFileName;
  String _compressionLevel = 'Medium';

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

  void _compressPdf() {
    if (_selectedFileName == null) {
      showAppSnackBar(context, 'Pilih file PDF terlebih dahulu.');
      return;
    }

    showAppSnackBar(
      context,
      'Kompresi dimulai (${_compressionLevel.toLowerCase()}) untuk $_selectedFileName.',
    );
  }

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
      uploadTitle: _selectedFileName ?? 'Select your PDF file',
      uploadSubtitle: uploadSubtitleOf(_selectedFileName),
      uploadedFiles: uploadedFilesOf(_selectedFileName),
      onUploadTap: _pickPdfFile,
      extraContent: _ToolCard(
        title: 'Compression Level',
        child: DropdownButtonFormField<String>(
          initialValue: _compressionLevel,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: const [
            DropdownMenuItem(value: 'Low', child: Text('Low - Better quality')),
            DropdownMenuItem(value: 'Medium', child: Text('Medium - Balanced')),
            DropdownMenuItem(
              value: 'High',
              child: Text('High - Smallest size'),
            ),
          ],
          onChanged: (value) {
            if (value == null) {
              return;
            }
            setState(() {
              _compressionLevel = value;
            });
          },
        ),
      ),
      actionLabel: 'Compress PDF',
      onActionTap: _compressPdf,
      isActionEnabled: _selectedFileName != null,
    );
  }
}
