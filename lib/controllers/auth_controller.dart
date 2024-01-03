import 'package:auth0_flutter/auth0_flutter_web.dart';

class AuthController {
  final auth0Web =
      Auth0Web('dev-jkyz1j05.us.auth0.com', 'gaGr2cQaHPrTFamCYdCHVFyxMG9PLTak',);
  
  final String audience = "https://sacred-sole-29.hasura.app/v1/graphql";
      
}
