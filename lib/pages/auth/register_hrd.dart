part of '../page.dart';


class register_hrd extends StatefulWidget {
  @override
  _registerHrdState createState() => _registerHrdState();
}

class _registerHrdState extends State<register_hrd> {

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

  final TextEditingController CompanyNameController = TextEditingController();
  String CompanyNameErrorMessage = '';
  bool CompanyNameIsEror = false;


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
          'Register HRD',
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
            Text(
              "Welcome Recruiter",
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

                companyname_input(
                companyNameInputController: CompanyNameController,
                label: "Company Name",
                isEror: CompanyNameIsEror),
            if (CompanyNameErrorMessage.isNotEmpty)
              Text(
                CompanyNameErrorMessage,
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
                    String Companyname = CompanyNameController.text;
                    String email = EmailController.text;
                    String pass = passwordController.text;
                    String confirmPass = confirmPasswordController.text;

                    // Reset semua error messages
                    CompanyNameErrorMessage = ' ';
                    emailErrorMessage = '';
                    passErrorMessage = '';
                    confirmPassErrorMessage = '';

                    // Reset status error
                    CompanyNameIsEror = false;
                    mailIsEror = false;
                    passIsEror = false;
                    confirmPassIsEror = false;

                    // Cek jika ada field yang kosong dan set error message yang sesuai
                    if (Companyname.isEmpty) {
                      CompanyNameErrorMessage = "*Nama Perusahan tidak boleh kosong";
                      CompanyNameIsEror = true;
                    } 
                    if (email.isEmpty) {
                      emailErrorMessage = "*Email tidak boleh kosong";
                      mailIsEror = true;
                    }
                    if (pass.isEmpty) {
                      passErrorMessage = "*Password tidak boleh kosong";
                      passIsEror = true;
                    }
                    if (confirmPass.isEmpty) {
                      confirmPassErrorMessage =
                          "*Konfirmasi password tidak boleh kosong";
                      confirmPassIsEror = true;
                    } else{
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepagehrd()),
                    );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: thirdColor, // Warna tombol
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
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
          ],
        )
      ),
    );   
  }
}
