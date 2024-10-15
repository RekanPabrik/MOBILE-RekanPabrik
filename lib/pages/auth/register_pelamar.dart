part of '../page.dart';

class register_pelamar extends StatefulWidget {
  @override
  _registerPelamarState createState() => _registerPelamarState();
}

class _registerPelamarState extends State<register_pelamar> {
  // VARIABLE
  final TextEditingController EmailController = TextEditingController();
  String emailErrorMessage = '';
  bool mailIsEror = false;

  final TextEditingController passwordController = TextEditingController();
  String passErrorMessage = '';
  bool passIsEror = false;

  final TextEditingController confirmPasswordController =
      TextEditingController();
  String confirmPassErrorMessage = '';
  bool confirmPassIsEror = false;

  final TextEditingController FNameController = TextEditingController();
  String FNameErrorMessage = '';
  bool FNameIsEror = false;

  final TextEditingController LNameController = TextEditingController();
  String LNameErrorMessage = '';
  bool LNameIsEror = false;

  String generalMassageEror = '';
  bool generalEror = false;

  // FUNGSI
  bool isEmailValid(String email) {
    return email.contains('@');
  }

  bool isPassValid(String pass) {
    return pass.isNotEmpty;
  }

  bool checkConfirmPass(String pass, String confirmPass) {
    return (pass == confirmPass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Register Page',
          style: TextStyle(
            color: thirdColor,
            fontFamily: 'poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: true,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: [
            SizedBox(
              height: 50,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 250,
                child: Text(
                  "If you are a recruiter, please create an account here",
                  style: TextStyle(
                    color: greyColor,
                    fontFamily: 'poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan aksi untuk pembuatan akun HRD
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: thirdColor, // Warna tombol
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Create Account HRD',
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            // Teks Welcome Applicants
            Text(
              "Welcome Applicants",
              style: TextStyle(
                color: thirdColor,
                fontFamily: 'poppins',
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            Text(
              "Sign up to your account to continue",
              style: TextStyle(
                color: greyColor,
                fontFamily: 'poppins',
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(
              height: 30,
            ),
            name_input(
                nameInputController: FNameController,
                label: "First Name",
                isEror: FNameIsEror),
            if (FNameErrorMessage.isNotEmpty)
              Text(
                FNameErrorMessage,
                style: TextStyle(color: Colors.red),
              ),

            SizedBox(height: 10),
            name_input(
                nameInputController: LNameController,
                label: "Last Name",
                isEror: LNameIsEror),
            if (LNameErrorMessage.isNotEmpty)
              Text(
                LNameErrorMessage,
                style: TextStyle(color: Colors.red),
              ),

            SizedBox(height: 10),
            EmailInput(emailController: EmailController, isEror: mailIsEror),
            if (emailErrorMessage.isNotEmpty)
              Text(
                emailErrorMessage,
                style: TextStyle(color: Colors.red),
              ),

            SizedBox(height: 10),
            PassInput(controller: passwordController, isEror: passIsEror),
            if (passErrorMessage.isNotEmpty)
              Text(
                passErrorMessage,
                style: TextStyle(color: Colors.red),
              ),

            SizedBox(height: 10),
            ConfirmPassInput(
                controller: confirmPasswordController,
                isEror: confirmPassIsEror),
            if (confirmPassErrorMessage.isNotEmpty)
              Text(
                confirmPassErrorMessage,
                style: TextStyle(color: Colors.red),
              ),

            SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 300,
                child: Text(
                  "by proceeding you confirm that you have read and agree to calendly terms of use and privacy notice",
                  style: TextStyle(
                    color: greyColor,
                    fontFamily: 'poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    String Fname = FNameController.text;
                    String Lname = LNameController.text;
                    String email = EmailController.text;
                    String pass = passwordController.text;
                    String confirmPass = confirmPasswordController.text;

                    // Reset semua error messages
                    FNameErrorMessage = '';
                    LNameErrorMessage = '';
                    emailErrorMessage = '';
                    passErrorMessage = '';
                    confirmPassErrorMessage = '';

                    // Reset status error
                    FNameIsEror = false;
                    LNameIsEror = false;
                    mailIsEror = false;
                    passIsEror = false;
                    confirmPassIsEror = false;

                    // Cek jika ada field yang kosong dan set error message yang sesuai
                    if (Fname.isEmpty) {
                      FNameErrorMessage = "Nama depan tidak boleh kosong";
                      FNameIsEror = true;
                    }
                    if (Lname.isEmpty) {
                      LNameErrorMessage = "Nama belakang tidak boleh kosong";
                      LNameIsEror = true;
                    }
                    if (email.isEmpty) {
                      emailErrorMessage = "Email tidak boleh kosong";
                      mailIsEror = true;
                    }
                    if (pass.isEmpty) {
                      passErrorMessage = "Password tidak boleh kosong";
                      passIsEror = true;
                    }
                    if (confirmPass.isEmpty) {
                      confirmPassErrorMessage =
                          "Konfirmasi password tidak boleh kosong";
                      confirmPassIsEror = true;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: thirdColor, // Warna tombol
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: greyColor,
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                children: <TextSpan>[
                  TextSpan(text: "already have an account? "),
                  TextSpan(
                    text: "login",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WellcomePage()),
                        );
                      },
                  ),
                ],
              ),
            ),

            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
