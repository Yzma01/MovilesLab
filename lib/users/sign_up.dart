// lib/screens/sign_up_screen.dart
import 'package:flutter/material.dart';
import 'auth_service.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userFullNameController = TextEditingController();
  final _userPhoneController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final AuthService _authService = AuthService();

  bool _passwordsMatch() {
    return _userPasswordController.text == _confirmPasswordController.text;
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_passwordsMatch()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = await _authService.registerUser(
        email: _userEmailController.text,
        password: _userPasswordController.text,
        fullName: _userFullNameController.text,
        phone: _userPhoneController.text,
      );

      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _userFullNameController,
                label: 'Nombre Completo',
                validator: (value) => value!.isEmpty ? 'Ingrese su nombre' : null,
              ),
              _buildTextField(
                controller: _userEmailController,
                label: 'Correo Electrónico',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) return 'Ingrese su email';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Email no válido';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _userPhoneController,
                label: 'Teléfono',
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Ingrese su teléfono' : null,
              ),
              _buildTextField(
                controller: _userPasswordController,
                label: 'Contraseña',
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value!.isEmpty) return 'Ingrese una contraseña';
                  if (value.length < 6) return 'Mínimo 6 caracteres';
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              _buildTextField(
                controller: _confirmPasswordController,
                label: 'Confirmar Contraseña',
                obscureText: _obscureConfirmPassword,
                validator: (value) {
                  if (!_passwordsMatch()) return 'Las contraseñas no coinciden';
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _registerUser,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Registrarse', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userEmailController.dispose();
    _userPasswordController.dispose();
    _userFullNameController.dispose();
    _userPhoneController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}