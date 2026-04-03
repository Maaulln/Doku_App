part of '../pdf_tool_screens.dart';

class RotatePdfScreen extends StatefulWidget {
  const RotatePdfScreen({super.key});

  @override
  State<RotatePdfScreen> createState() => _RotatePdfScreenState();
}

class _RotatePdfScreenState extends State<RotatePdfScreen>
    with _PdfPickerMixin<RotatePdfScreen> {
  String? _selectedFileName;
  String _pageRange = 'All';
  int _selectedAngle = 90;

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

  void _rotatePdf() {
    if (_selectedFileName == null) {
      showAppSnackBar(context, 'Pilih file PDF terlebih dahulu.');
      return;
    }

    showAppSnackBar(
      context,
      'Memutar $_selectedFileName ($_selectedAngle°) untuk halaman $_pageRange.',
    );
  }

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
      uploadTitle: _selectedFileName ?? 'Select your PDF file',
      uploadSubtitle: uploadSubtitleOf(_selectedFileName),
      uploadedFiles: uploadedFilesOf(_selectedFileName),
      onUploadTap: _pickPdfFile,
      extraContent: _ToolCard(
        title: 'Rotate Options',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _pageRange = value.trim().isEmpty ? 'All' : value.trim();
                });
              },
              decoration: InputDecoration(
                hintText: 'Page range (default all), contoh: 1-5',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [90, 180, 270]
                  .map(
                    (angle) => ChoiceChip(
                      label: Text('$angle°'),
                      selected: _selectedAngle == angle,
                      onSelected: (_) {
                        setState(() {
                          _selectedAngle = angle;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      actionLabel: 'Rotate PDF',
      onActionTap: _rotatePdf,
      isActionEnabled: _selectedFileName != null,
    );
  }
}
