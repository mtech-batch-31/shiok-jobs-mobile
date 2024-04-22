const amplifyconfig = ''' {
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
  "auth": {
    "plugins": {
      "awsCognitoAuthPlugin": {
        "IdentityManager": {
          "Default": {}
        },
        "CredentialsProvider": {
          "CognitoIdentity": {
            "Default": {
              "PoolId": "ap-southeast-1_MB8MD8ix8",
              "Region": "ap-southeast-1"
            }
          }
        },
        "CognitoUserPool": {
          "Default": {
            "PoolId": "ap-southeast-1_MB8MD8ix8",
            "AppClientId": "5i5fgd57n42nmala1b7ahmfsl0",
            "Region": "ap-southeast-1"
          }
        },
        "GoogleSignIn": {
            "Permissions": "email,phone,openid",
            "ClientId-WebApp": "305877766170-5sidfbdmb348d1khdak0107rhtgn8u3k.apps.googleusercontent.com",
            "ClientId-iOS": "305877766170-5sidfbdmb348d1khdak0107rhtgn8u3k.apps.googleusercontent.com",
            "ClientId-Android": "305877766170-5sidfbdmb348d1khdak0107rhtgn8u3k.apps.googleusercontent.com"
        },
        "Auth": {
          "Default": {
            "authenticationFlowType": "REFESH_TOKEN_AUTH",
            "OAuth": {
              "WebDomain": "shiok-jobs.auth.ap-southeast-1.amazoncognito.com",
              "AppClientId": "5i5fgd57n42nmala1b7ahmfsl0",
              "SignInRedirectURI": "myapp://signin",
              "SignOutRedirectURI": "myapp://signout",
              "Scopes": [
                "phone",
                "email",
                "openid"
              ]
            }
          }
        }
      }
    }
  }
}''';
