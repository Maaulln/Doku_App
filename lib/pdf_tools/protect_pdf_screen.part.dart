part of '../pdf_tool_screens.dart';

class ProtectPdfScreen extends StatefulWidget {
  const ProtectPdfScreen({super.key});

  @override
  State<ProtectPdfScreen> createState() => _ProtectPdfScreenState();
}

class _ProtectPdfScreenState extends State<ProtectPdfScreen>
    with _PdfPickerMixin<ProtectPdfScreen> {
  String? _selectedFileName;
  bool _allowPrint = false;
  bool _allowCopy = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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

  void _protectPdf() {
    if (_selectedFileName == null) {
      showAppSnackBar(context, 'Pilih file PDF terlebih dahulu.');
      return;
    }

    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password.length < 6) {
      showAppSnackBar(context, 'Password minimal 6 karakter.');
      return;
    }

    if (password != confirmPassword) {
      showAppSnackBar(context, 'Konfirmasi password tidak cocok.');
      return;
    }

    showAppSnackBar(
      context,
      'PDF berhasil diproteksi (print: ${_allowPrint ? 'on' : 'off'}, copy: ${_allowCopy ? 'on' : 'off'}).',
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canProtect =
        _selectedFileName != null && _passwordController.text.length >= 6;

    return _PdfToolScreen(
      title: 'Protect PDF',
      subtitle: 'Add password protection to your PDF files',
      steps: const [
        'Select your PDF',
        'Set password and permissions',
        'Click Protect',
      ],
      uploadTitle: _selectedFileName ?? 'Select your PDF file',
      uploadSubtitle: uploadSubtitleOf(_selectedFileName),
      uploadedFiles: uploadedFilesOf(_selectedFileName),
      onUploadTap: _pickPdfFile,
      extraContent: _ToolCard(
        title: 'Security Options',
        child: Column(
          children: [
            TextField(
              controller: _passwordController,
              obscureText: true,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Password (min. 6 karakter)',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Konfirmasi password',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              value: _allowPrint,
              title: const Text('Allow printing'),
              onChanged: (value) {
                setState(() {
                  _allowPrint = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              value: _allowCopy,
              title: const Text('Allow copying content'),
              onChanged: (value) {
                setState(() {
                  _allowCopy = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
      actionLabel: 'Protect PDF',
      onActionTap: _protectPdf,
      isActionEnabled: canProtect,
    );
  }
}
