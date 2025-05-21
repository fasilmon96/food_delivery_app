 class Validation{
   static  nameValidation(value){
     final nameValid =  RegExp(r'^[a-zA-Z]{5,}$');
     if(!nameValid.hasMatch(value!)){
       return "Please Enter Your Name \n"
           "Please Use 5 Letter";
     }
     return null;
   }
  static  emailValidation(value){
    final emailValid= RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if(!emailValid.hasMatch(value!)){
      return "Please Enter Your Valid Email";
    }
     return null;
  }
  static  passwordValidation(value){
    final passwordValid = RegExp( r'^[a-zA-Z-0-9]{8,}$');
    if(!passwordValid.hasMatch(value!)){
      return "Please Enter at Least 8 digits ";
    }
     return null;
  }
   static  numberValidation(value){
     final numberValid = RegExp( r'^[0-9]{2,}$');
     if(!numberValid.hasMatch(value!)){
       return "Enter at Least 2 digits above ₹ 50 ";
     }
     return null;
   }

 }


