part of '../pdf_tool_screens.dart';

class MergePdfScreen extends StatefulWidget {
  const MergePdfScreen({super.key});

  @override
  State<MergePdfScreen> createState() => _MergePdfScreenState();
}

class _MergePdfScreenState extends State<MergePdfScreen>
    with _PdfPickerMixin<MergePdfScreen> {
  List<String> _selectedFiles = const [];

  Future<void> _pickPdfFiles() async {
    final selectedFiles = await pickPdfFileNames(allowMultiple: true);

    if (!mounted) {
      return;
    }

    if (selectedFiles == null) {
      showCancelledSelection();
      return;
    }

    setState(() {
      _selectedFiles = selectedFiles;
    });

    showAppSnackBar(context, '${_selectedFiles.length} file terpilih.');
  }

  void _moveFile(int fromIndex, int toIndex) {
    if (toIndex < 0 || toIndex >= _selectedFiles.length) {
      return;
    }

    final updated = List<String>.from(_selectedFiles);
    final movedItem = updated.removeAt(fromIndex);
    updated.insert(toIndex, movedItem);

    setState(() {
      _selectedFiles = updated;
    });
  }

  void _mergeFiles() {
    if (_selectedFiles.length < 2) {
      showAppSnackBar(context, 'Pilih minimal 2 file untuk digabungkan.');
      return;
    }

    showAppSnackBar(
      context,
      'Menggabungkan ${_selectedFiles.length} file PDF.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return _PdfToolScreen(
      title: 'Merge PDF',
      subtitle: 'Combine multiple PDF files into a single document',
      steps: const ['Select your PDF files', 'Drag to reorder', 'Click Merge'],
      uploadTitle: _selectedFiles.isEmpty
          ? 'Select your PDF files'
          : '${_selectedFiles.length} file selected',
      uploadSubtitle: _selectedFiles.isEmpty
          ? 'Drag & drop or browse files from your computer'
          : 'Upload lagi untuk mengganti daftar file',
      uploadedFiles: _selectedFiles,
      onUploadTap: _pickPdfFiles,
      extraContent: _selectedFiles.length > 1
          ? _OrderFilesCard(
              files: _selectedFiles,
              onMoveUp: (index) => _moveFile(index, index - 1),
              onMoveDown: (index) => _moveFile(index, index + 1),
            )
          : null,
      actionLabel: 'Merge PDF',
      onActionTap: _mergeFiles,
      isActionEnabled: _selectedFiles.length > 1,
    );
  }
}
