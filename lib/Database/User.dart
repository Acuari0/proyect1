
import 'package:firebase_database/firebase_database.dart';

class UserC {
  String key,email;
  int credits,treat,N1,N2,N3,N4,N5,N6,N7,N8,S1,S2,S3,S4,S5,S6,S7,S8;

  UserC(this.key,
      this.email,
      this.credits,
      this.treat,
      this.N1,this.N2,this.N3,this.N4,this.N5,this.N6,this.N7,this.N8,
      this.S1,this.S2,this.S3,this.S4,this.S5,this.S6,this.S7,this.S8);


  UserC.fromSnapshot(DataSnapshot snapshot)
      : key =  snapshot.key,
        email = snapshot.value["Email"],
        credits = snapshot.value["Creditos"],
        treat = snapshot.value["Treat"],
        N1= snapshot.value["N1"],
        N2= snapshot.value["N2"],
        N3= snapshot.value["N3"],
        N4= snapshot.value["N4"],
        N5= snapshot.value["N5"],
        N6= snapshot.value["N6"],
        N7= snapshot.value["N7"],
        N8= snapshot.value["N8"],
        S1= snapshot.value["S1"],
        S2= snapshot.value["S2"],
        S3= snapshot.value["S3"],
        S4= snapshot.value["S4"],
        S5= snapshot.value["S5"],
        S6= snapshot.value["S6"],
        S7= snapshot.value["S7"],
        S8= snapshot.value["S8"];



  toJson() {
    return {
      "Email": email,
      "Creditos": credits,
      "Treat": treat,
      "N1":N1,
      "N2":N2,
      "N3":N3,
      "N4":N4,
      "N5":N5,
      "N6":N6,
      "N7":N7,
      "N8":N8,
      "S1":S1,
      "S2":S2,
      "S3":S3,
      "S4":S4,
      "S5":S5,
      "S6":S6,
      "S7":S7,
      "S8":S8,
    };
  }

}
