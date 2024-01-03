import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:performance_nos_estudos_app/controllers/auth_controller.dart';
import 'package:performance_nos_estudos_app/models/usuario_model.dart';
import 'package:performance_nos_estudos_app/responsive/responsive_layout.dart';
import 'package:performance_nos_estudos_app/stores/user_store.dart';
import 'package:performance_nos_estudos_app/view/desktop/home_page_desktop.dart';
import 'package:performance_nos_estudos_app/view/mobile/home_page_mobile.dart';

import '../controllers/dashboard_controller.dart';
import '../controllers/revisoes_controller.dart';
import '../services/database_service.dart';
import '../stores/area_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authController = AuthController();
  bool loading = false;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _authController.auth0Web
          .onLoad(audience: _authController.audience)
          .then((final credentials) => {
                if (credentials != null)
                  {
                    //Gerar as instâncias com o Token de autenticação
                    GetIt.I.registerSingleton<UsuarioStore>(UsuarioStore(
                        user: UsuarioModel(
                            email: credentials.user.email!,
                            id: credentials.user.sub,
                            nome: credentials.user.nickname!))),
                    GetIt.I.registerSingleton<HasuraService>(HasuraService(
                        HasuraConnect(
                            "https://sacred-sole-29.hasura.app/v1/graphql",
                            headers: {
                          "content-type": "application/json",
                          "Authorization":
                              "${credentials.tokenType} ${credentials.accessToken}"
                        }))),
                    GetIt.I
                        .registerSingleton<IDatabase>(GetIt.I<HasuraService>()),
                    GetIt.I.registerSingleton<AreaStore>(AreaStore()),
                    GetIt.I.registerSingleton<RevisoesController>(
                        RevisoesController()),
                    GetIt.I.registerSingleton<DashboardController>(
                        DashboardController()),

                    //Redirecionar para a página inicial da plataforma
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResponsiveLayout(
                              mobileHome: HomePageMobile(),
                              desktopHome: HomePageDesktop())),
                    ),
                  }
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xff4777e6), Color(0xff0740b0)],
          stops: [0.25, 0.75],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Image.asset(
                        "assets/images/logo.png",
                        scale: mediaQuery.width < 470 ? 7 : 3.5,
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    SizedBox(
                      width: 105,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          if (kIsWeb) {
                            await _authController.auth0Web.loginWithRedirect(
                                redirectUrl: 'http://localhost:3000',//'http://agricolavetrosso.ddns.net/performance/',
                                audience: _authController.audience);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          //shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.white,
                        ),
                        child: SizedBox(
                          child: Center(
                            child: Text(
                              "Entrar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.blue[900]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 105,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          if (kIsWeb) {
                            await _authController.auth0Web.loginWithRedirect(
                                redirectUrl: 'http://localhost:3000',//'http://agricolavetrosso.ddns.net/performance/',
                                audience: _authController.audience,
                                parameters: {"screen_hint": "signup"});
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          //shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.white,
                        ),
                        child: SizedBox(
                          child: Center(
                            child: Text(
                              "Registrar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.blue[900]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Image.asset(
                    "assets/images/image_test.png",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "A plataforma que vai organizar a sua rotina de estudos de forma eficiente\npara garantir os melhores resultados!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 35),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Wrap(
                  spacing: 50,
                  runAlignment: WrapAlignment.spaceBetween,
                  //scrollDirection: Axis.horizontal,
                  //crossAxisCount: mediaQuery.width < 950 ? 1 : 3,
                  //shrinkWrap: true,
                  //crossAxisSpacing: 10,
                  //mainAxisSpacing: 20,
                  //childAspectRatio: 2,
                  //padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                      width: 350,
                      height: 350,
                      child: Card(
                        elevation: 3,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.timer,
                                size: 30,
                                color: Colors.blue[700],
                              ),
                              const Text(
                                "\nEstude suas revisões de forma programada e periodizada\n",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Na plataforma você consegue saber a data mais adequada para realizar a revisão do estudo adicionado.",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      height: 350,
                      child: Card(
                        elevation: 3,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.bar_chart,
                                size: 30,
                                color: Colors.blue[700],
                              ),
                              const Text(
                                "\nAcompanhe seu desempenho em cada conteúdo\n",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "No dashboard você consegue acompanhar o percentual de acerto das suas revisões em gráficos de forma simples e prática.",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      height: 350,
                      child: Card(
                        elevation: 3,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 30,
                                color: Colors.blue[700],
                              ),
                              const Text(
                                "\nNão perca a data de revisão de nenhum conteúdo\n",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Conte com um calendário customizado para não perder a data de nenhuma revisão!",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
          Visibility(
            visible: loading,
            child: Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
        ]),
      ),
    );
  }

  // _header(context) {
  //   return const Column(
  //     children: [
  //       Text(
  //         "Welcome Back",
  //         style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
  //       ),
  //       Text("Enter your credential to login"),
  //     ],
  //   );
  // }

  // _inputField(context) {
  //   return Card(
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(
  //       side: const BorderSide(color: Colors.white70, width: 1),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Padding(
  //       padding:
  //           const EdgeInsets.only(bottom: 30, left: 32, right: 32, top: 50),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           SizedBox(
  //             width: 550,
  //             child: TextField(
  //               decoration: InputDecoration(
  //                   hintText: "Email",
  //                   border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(18),
  //                       borderSide: BorderSide.none),
  //                   fillColor: Colors.blue.withOpacity(0.1),
  //                   filled: true,
  //                   prefixIcon: const Icon(Icons.email)),
  //             ),
  //           ),
  //           const SizedBox(height: 10),
  //           SizedBox(
  //             width: 550,
  //             child: TextField(
  //               decoration: InputDecoration(
  //                 hintText: "Senha",
  //                 border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(18),
  //                     borderSide: BorderSide.none),
  //                 fillColor: Colors.blue.withOpacity(0.1),
  //                 filled: true,
  //                 prefixIcon: const Icon(Icons.password),
  //               ),
  //               obscureText: true,
  //             ),
  //           ),
  //           const SizedBox(height: 10),
  //           ElevatedButton(
  //             onPressed: () async {
  //               if (kIsWeb) {
  //                 await _authController.auth0Web
  //                     .loginWithRedirect(redirectUrl: 'http://localhost:3000');
  //               }
  //             },
  //             style: ElevatedButton.styleFrom(
  //               shape: const StadiumBorder(),
  //               padding: const EdgeInsets.symmetric(vertical: 16),
  //               backgroundColor: Colors.blue[700],
  //             ),
  //             child: const SizedBox(
  //               width: 300,
  //               child: Center(
  //                 child: Text(
  //                   "Login",
  //                   style: TextStyle(fontSize: 20),
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // _forgotPassword(context) {
  //   return TextButton(
  //     onPressed: () {},
  //     child: Text(
  //       "Esqueceu sua senha?",
  //       style:
  //           TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w600),
  //     ),
  //   );
  // }

  // _signup(context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       const Text("Não tem uma conta? "),
  //       TextButton(
  //           onPressed: () {
  //           },
  //           child: Text(
  //             "Cadastre-se",
  //             style: TextStyle(
  //                 color: Colors.blue.shade900, fontWeight: FontWeight.w600),
  //           ))
  //     ],
  //   );
  // }
}
