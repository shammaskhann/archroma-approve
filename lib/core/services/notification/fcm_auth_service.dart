import 'dart:developer';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class FcmAuthService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "archroma-approve",
      "private_key_id": "69da565450e5e36e5852b8ce71105d2d541454bc",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCLuJ3GJrHK7i8v\nR8k5sTM6WAX8ShG2NSUAwAXcfdYel5FxqIvNp7+W/88KBGAE6dNAFRWApWENay9f\n546hQ9RnBfKfgW/nccCNnH5BjiG21y0/RzqYv3UW+TirCwEH4g1+oVwK8B4RhjSa\n2t9+a5ZBz93qapRBTNtHtrYMg3sOQcDejfZXNjDX2vJCGKrFm+iLrElgq8ZHn7z8\n6Y9nqOtoeR2prvZ0NBV0y83b8BUrk1ADBY84C9sZwSG/6zczEzpKJvJiAQeR6cX5\nr1ur3Ew5TqKoi7f3U6o11qTid5SwptVKeSu7i9YYhYyvfEN7I79+IvX5DgSY6xH6\n5z3PwX91AgMBAAECggEAJqkgzvFqBLK/T5/XaCVF/YDZtyNvnzE5WenINWiEVNav\nofl3JaKi+s8xpJ3tS66/i13KI1yfbC0aYLkb2DeCkDcvGT+hjTMGiqigrtb7MTJ9\nDKNS7W0cowy2x202Dc5Y2Y8gfs5OI5808xxY9wwh+Xfg+bof56myizddTD0dUaYr\nYBFmexz7L8WZkcbTZ1860PO0cwPse0VguIwIZjb8Qd2m/Bi3exSv4iQi6C6B8xN4\nLRPXG57V8fUP9eSns+CndYbHBN4oV9MRMvr66FtM27Hh8IwFXRn30CPMvwtFZkTQ\nM43AUmCl+HUrnbHD8MAskPSl0UmwA8LEd0GmZOtxSQKBgQDAbigma+dNcSJMarLH\nAQwkTMjs+m1BC4gmNrrNuhB7hR+WKfac4BtGzCmPmDxrudwgIdZZoJAYkTD5LHnG\n2bhrrtWhHLuFIbWE/oKd7wuikovW3Dh6/Ji7Zr3rRFT7Fa5hRO4cgeaeNOJGrXpI\ncDntMPzGWWf+RJ4puf0V2OjiiwKBgQC54NgDEoh7YCjqoPwp+86dBpToCS3I3f1G\nVfgU6MFB03SCXSMqg82pjBax2dwepoWXCjVj2Ni2lEQf83WJ3YOkpebzibHbAmjP\nwthLSQYCH58OgncDI8rQ2dTAsU5UIJmqB1KXvGmq1+7FVQZyYaz1RIVEoX2hoCBo\nJ4fK+xVl/wKBgA1bWBQap0p70NqnCVPA4dvfLI8ubsj2CPRGFj9Ta/N28RNWRFTt\nRVdrsnLSKVd85ieg0aUU/QuHgHO7P5Sq5h8rWo69VNLP3S6nD9/wiMk3DNfUH2OC\nBwPzBLnA23k2Lw13YGPALIbMuuwW/Ibsq0ioftMxv4MptiTFUSjkDn4zAoGAAReK\nDVKRjK/+7YnukUySZSfBvi83nqN3Nm+Q2oaXhAx69b0YVMqbbbCN/ZN7EI8H3+BG\negSvGTt7vvhOK3YqrM/wsGORsOittvK9FIwkReTrqUko69LNATcWYd9ox2O9o1sR\nqCSKNl+4Xl5mgEuEmZhCdCnCtC1do18AFDgvYv8CgYAh4Z3fG4et0CHIFfx+AkcJ\nGt5n0deru2jKUvNC6GFxrnRaEM5VD2EX+BX6N8/EwyffYinWhtRYHXD8QgNJmfCb\nhsNodd/5ddR2r4n6++atfpoB2v1H6lb9YYjbj2vb6G2+vUzLU4mRsiJhO0scRsr1\nM2UKsS04xWXokLZE3P8ZQQ==\n-----END PRIVATE KEY-----\n",
      "client_email":
          "arch-approve-notification@archroma-approve.iam.gserviceaccount.com",
      "client_id": "105488982485376568593",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/arch-approve-notification%40archroma-approve.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com",
    };

    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    final credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close();
    return credentials.accessToken.data;
  }
}
