bool EmailOk(String email){
  if(email.contains("@gmail.com") || email.contains("@yahoo.com")||
      email.contains("@hotmail.com")|| email.contains("@outlook.com")&&
  email.isNotEmpty)
    return true;
  return false;
}

bool PasswordOK(String Password){
  if(Password.length>6 && Password.isNotEmpty)
    return true;
  return false;
}

bool AllParametersOk(String email, String Password){
  if((EmailOk(email)) &&((PasswordOK(Password))))
    return true;
  return false;
}