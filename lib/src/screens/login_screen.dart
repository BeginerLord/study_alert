import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIMA Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _cedulaError;
  String? _passwordError;

  String? _loginMessage;
  bool _isLoading = false;
  bool _obscurePassword = true;

  final List<Map<String, String>> _validUsers = [
    {"cc": "1062957207", "password": "password123"},
  ];

  @override
  void dispose() {
    _cedulaController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _launchForgotPasswordUrl() async {
    final Uri url = Uri.parse('https://sma.unicartagena.edu.co:8443/Smaix12/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace')),
      );
    }
  }

  bool _validateForm() {
    bool isValid = true;

    if (_cedulaController.text.isEmpty) {
      setState(() {
        _cedulaError = "Por favor ingrese su cédula";
      });
      isValid = false;
    } else {
      setState(() {
        _cedulaError = null;
      });
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = "Por favor ingrese su contraseña";
      });
      isValid = false;
    } else {
      setState(() {
        _passwordError = null;
      });
    }

    return isValid;
  }

  void _attemptLogin() async {
    if (!_validateForm()) return;

    setState(() {
      _isLoading = true;
      _loginMessage = null;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    final String cedula = _cedulaController.text;
    final String password = _passwordController.text;

    bool isValidUser = _validUsers.any(
      (user) => user["cc"] == cedula && user["password"] == password,
    );

    setState(() {
      _isLoading = false;
    });

    if (isValidUser) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(userCedula: cedula),
        ),
      );
    } else {
      setState(() {
        _loginMessage = "Cédula o contraseña incorrectos";
        _cedulaController.clear();
        _passwordController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Colors.white70),
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/logo_screen.jpg',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withAlpha((0.5 * 215).toInt())),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      child:
                          Image.asset('assets/logo-ctv-udc-removebg-preview.png'),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Hola, bienvenido a StudyAlertUdc 2025-1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 0),
                            blurRadius: 4,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Ingrese sus datos para iniciar sesión en su cuenta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _cedulaController,
                      decoration: InputDecoration(
                        labelText: 'Nombre de usuario',
                        labelStyle: const TextStyle(color: Colors.white),
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        focusedBorder: inputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: Colors.lightBlueAccent, width: 2),
                        ),
                        errorText: _cedulaError,
                        errorStyle: const TextStyle(color: Colors.redAccent),
                        hintText: 'Ingrese su número de cédula',
                        hintStyle: const TextStyle(color: Colors.white54),
                        prefixIcon: const Icon(Icons.person, color: Colors.white),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: const TextStyle(color: Colors.white),
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: const TextStyle(color: Colors.white),
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        focusedBorder: inputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: Colors.lightBlueAccent, width: 2),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        errorText: _passwordError,
                        errorStyle: const TextStyle(color: Colors.redAccent),
                        hintText: 'Ingrese su contraseña',
                        hintStyle: const TextStyle(color: Colors.white54),
                        prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      ),
                      obscureText: _obscurePassword,
                      style: const TextStyle(color: Colors.white),
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _launchForgotPasswordUrl,
                        child: const Text(
                          '¿Olvidó su contraseña?',
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _attemptLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF62A8EA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Acceder',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                      ),
                    ),
                    if (_loginMessage != null) ...[
                      const SizedBox(height: 24),
                      Text(
                        _loginMessage!,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String userCedula;

  const HomeScreen({super.key, required this.userCedula});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: const Color(0xFF62A8EA),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          '¡Bienvenido, usuario $userCedula!',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}