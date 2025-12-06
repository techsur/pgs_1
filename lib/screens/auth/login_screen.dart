import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:pgs_1/screens/auth/register_screen.dart';
import 'package:pgs_1/screens/auth/forgot_password_screen.dart';
import 'package:pgs_1/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _countryCode = '+91'; // Default India
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = true;
  String _loginMethod = 'phone'; // 'phone' or 'email'

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    // Navigate to home on successful login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2196F3),
              Color(0xFF1976D2),
              Color(0xFF0D47A1),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button (optional)
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),

                  const SizedBox(height: 20),

                  // Welcome Section
                  _buildWelcomeSection(),

                  const SizedBox(height: 40),

                  // Login Card
                  _buildLoginCard(),

                  const SizedBox(height: 30),

                  // Alternative Login Methods
                  _buildAlternativeLogin(),

                  const SizedBox(height: 40),

                  // Sign Up Link
                  _buildSignUpSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue your learning journey',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Login Method Toggle
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _loginMethod = 'phone'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _loginMethod == 'phone'
                                ? Colors.blue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Mobile',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: _loginMethod == 'phone'
                                    ? Colors.white
                                    : Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _loginMethod = 'email'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _loginMethod == 'email'
                                ? Colors.blue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: _loginMethod == 'email'
                                    ? Colors.white
                                    : Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Phone/Email Field
              if (_loginMethod == 'phone')
                _buildPhoneField()
              else
                _buildEmailField(),

              const SizedBox(height: 20),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      const Text('Remember me'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                      : const Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Terms Text
              Text(
                'By signing in, you agree to our Terms of Service and Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CountryCodePicker(
            onChanged: (country) {
              setState(() {
                _countryCode = country.dialCode!;
              });
            },
            initialSelection: 'IN',
            favorite: const ['+91', 'IN'],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Mobile Number',
              prefixIcon: const Icon(Icons.phone_android),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number';
              }
              if (value.length != 10) {
                return 'Enter a valid 10-digit number';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _phoneController, // Reusing controller for email
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildAlternativeLogin() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(color: Colors.white.withOpacity(0.3)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or continue with',
                style: TextStyle(color: Colors.white.withOpacity(0.8)),
              ),
            ),
            Expanded(
              child: Divider(color: Colors.white.withOpacity(0.3)),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google Login
            _buildSocialButton(
              icon: Icons.g_mobiledata,
              color: Colors.white,
              onPressed: () {
                // Handle Google login
              },
            ),

            const SizedBox(width: 20),

            // Facebook Login
            _buildSocialButton(
              icon: Icons.facebook,
              color: const Color(0xFF1877F2),
              onPressed: () {
                // Handle Facebook login
              },
            ),

            const SizedBox(width: 20),

            // Apple Login (iOS only)
            if (Theme.of(context).platform == TargetPlatform.iOS)
              _buildSocialButton(
                icon: Icons.apple,
                color: Colors.black,
                onPressed: () {
                  // Handle Apple login
                },
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 30,
          color: color,
        ),
      ),
    );
  }

  Widget _buildSignUpSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterScreen(),
              ),
            );
          },
          child: const Text(
            'Sign Up Now',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}