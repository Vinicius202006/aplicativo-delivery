
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //============ VARIAVEIS E FUNCOES ===========

  final Color vermelho = const Color(0xFFE53935);
  final Color vermelhoEscuro = const Color(0xFFC62828);
  final Color fundo = const Color(0xFFF8F8FA);
  final Color texto = const Color(0xFF292929);
  final Color cinza = const Color(0xFF777777);

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController senhaController =
      TextEditingController();

  bool ocultarSenha = true;

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 32,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // LOGO
                  Center(
                    child: Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: fundo,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Icon(
                        Icons.delivery_dining,
                        size: 48,
                        color: vermelho,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // TITULO
                  Text(
                    'Entrar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: texto,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Peça sua comida favorita.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: cinza,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // EMAIL
                  Text(
                    'E-mail',
                    style: TextStyle(
                      fontSize: 13,
                      color: texto,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Digite seu e-mail',
                      hintStyle: TextStyle(
                        color: cinza.withOpacity(0.6),
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: fundo,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: vermelho,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // SENHA
                  Text(
                    'Senha',
                    style: TextStyle(
                      fontSize: 13,
                      color: texto,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: senhaController,
                    obscureText: ocultarSenha,
                    decoration: InputDecoration(
                      hintText: 'Digite sua senha',
                      hintStyle: TextStyle(
                        color: cinza.withOpacity(0.6),
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: fundo,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 16,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            ocultarSenha = !ocultarSenha;
                          });
                        },
                        icon: Icon(
                          ocultarSenha
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: cinza,
                          size: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: vermelho,
                        ),
                      ),
                    ),
                  ),

                  // ESQUECI MINHA SENHA
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Recuperação de senha em breve.',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Esqueci minha senha',
                        style: TextStyle(
                          color: vermelhoEscuro,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // BOTAO ENTRAR
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (emailController.text.trim().isEmpty ||
                            senhaController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Preencha o e-mail e a senha.',
                              ),
                            ),
                          );
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Conecte a autenticação para continuar.',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: vermelho,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // DIVISOR
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          'ou',
                          style: TextStyle(
                            color: cinza,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // CONTINUAR COM GOOGLE
                  SizedBox(
                    height: 46,
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Configure o login com Google.',
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: texto,
                        side: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image.asset(
      'assets/google_logo.png',
      width: 22,
      height: 22,
    ),
                          const SizedBox(width: 12),
                          const Text(
                            'Continuar com Google',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // CRIAR CONTA
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        'Não tem uma conta? ',
                        style: TextStyle(
                          color: cinza,
                          fontSize: 12,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Tela de cadastro em breve.',
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Criar conta',
                          style: TextStyle(
                            color: vermelhoEscuro,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
