part of "../page.dart";



class ResetPassword extends StatefulWidget{
  @override
  _resetPassword createState() => _resetPassword();
}

class _resetPassword extends State<ResetPassword>{
   // VARIABLE
  final TextEditingController EmailController = TextEditingController();
  String emailErrorMessage = '';
  bool mailIsEror = false;

  String generalMassageEror = '';
  bool generalEror = false;

  // FUNGSI
  bool isEmailValid(String email) {
    return email.contains('@');
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Reset Password',
          style: TextStyle(
            color: thirdColor,
            fontFamily: 'poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true),
        body: SafeArea(
        bottom: true,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Cari Akun Anda",
              style: TextStyle(
                color: thirdColor,
                fontFamily: 'poppins',
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
                "Masukan Email Anda",
                style: TextStyle(
                  color: greyColor,
                  fontFamily: 'poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              ),
               SizedBox(
              height: 30,
            ),

             
            EmailInput(emailController: EmailController, isEror: mailIsEror),
            if (emailErrorMessage.isNotEmpty)
              Text(
                emailErrorMessage,
                style: TextStyle(color: Colors.red),
              ),
               SizedBox(height: 10),
           
           

            SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 300,
                
              ),
            ),

            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    String email = EmailController.text;

                    // Reset semua error messages
                    emailErrorMessage = '';
                   

                    // Reset status error
                    mailIsEror = false;
           

                    // Cek jika ada field yang kosong dan set error message yang sesuai
                
                 if (email.isEmpty) {
                     emailErrorMessage = "*Email tidak boleh kosong";
                    mailIsEror = true;
                  }else if (!email.contains('@')) {
                    emailErrorMessage = "*Email harus mengandung '@'";
                    mailIsEror = true;
                  }else{
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => login_page()),
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
                  'Reset Password',
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