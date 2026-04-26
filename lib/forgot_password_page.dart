import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool loading = false;

  void sendReset() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => loading = false);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Berhasil"),
        content: const Text("Link reset dikirim"),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lupa Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Email wajib";
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: loading ? null : sendReset,
                child: const Text("Kirim"),
              )
            ],
          ),
        ),
      ),
    );
  }
}