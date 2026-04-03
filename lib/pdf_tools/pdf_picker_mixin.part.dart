part of '../pdf_tool_screens.dart';

mixin _PdfPickerMixin<T extends StatefulWidget> on State<T> {
  Future<List<String>?> pickPdfFileNames({bool allowMultiple = false}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
      allowMultiple: allowMultiple,
      withData: false,
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    final names = result.files
        .map((file) => file.name.trim())
        .where((name) => name.isNotEmpty)
        .toList();

    return names.isEmpty ? null : names;
  }

  List<String> uploadedFilesOf(String? fileName) {
    return fileName == null ? const [] : [fileName];
  }

  String uploadSubtitleOf(String? fileName) {
    return fileName == null
        ? 'Drag & drop or browse files from your computer'
        : 'Klik lagi untuk mengganti file PDF';
  }

  void showCancelledSelection() {
    showAppSnackBar(context, 'Pemilihan file dibatalkan.');
  }
}
