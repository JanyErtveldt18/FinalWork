//Initialiseren firestore door firebase
//var db = firebase.Firestore();



//Gegevens ouder
const txtFirstname = document.getElementById("firstname");
const txtLastname = document.getElementById("lastname");
const txtAdress = document.getElementById("adress");
const txtGemeente = document.getElementById("gemeente");
const txtPostcode = document.getElementById("postcode");
const txtGsm = document.getElementById("gsm");

//Gegevens kind
const txtFirstnameChild = document.getElementById("firstname_child");
const txtLastnameChild = document.getElementById("lastname_child");
const txtLeeftijdChild = document.getElementById("leeftijd_child");
const txtBeschrijvingChild = document.getElementById("beschrijving_child");

//QR-code
//qr_code
const txtQr_code = document.getElementById("qr_code");

//Account ouder
const txtEmail = document.getElementById("email");
const txtPassword = document.getElementById("password");

const btnLogout = document.getElementById("btnLogout");

function addDataUserToDatabase(userIdEmail){
  console.log("Voeg gegevens user toe aan account + userid");
  console.log(userIdEmail);
  var firstname_input = txtFirstname.value;
  var lastname_input = txtLastname.value;
  var adress_input = txtAdress.value;
  var gemeente_input = txtGemeente.value;
  var postcode_input = txtPostcode.value;
  var gsm_input = txtGsm.value;
  
  var firstnameChild_input = txtFirstnameChild.value;
  var lastnameChild_input = txtLastnameChild.value;
  var leeftijdChild_input = txtLeeftijdChild.value;
  var beschrijvingChild_input = txtBeschrijvingChild.value;
  
  var QR_code_input = txtQr_code.value;
  
  
  db.collection("Users").doc(userIdEmail).set({
    name: firstname_input,
    lastname: lastname_input,
    adress: adress_input,
    gemeente: gemeente_input,
    postcode: postcode_input,
    gsm: gsm_input,
    
    firstnamechild: firstnameChild_input,
    lastnamechild: lastnameChild_input,
    leeftijdChild: leeftijdChild_input,
    beschrijvingchild: beschrijvingChild_input,
    qrcode : QR_code_input
    
})
.then(function() {
    console.log("User gegevens met succes naar database geschreven!");
    firebase.auth().signOut();
    txtFirstname.value = "";
    txtLastname.value = "";
    txtAdress.value = "";
    txtGemeente.value = "";
    txtPostcode.value = "";
    txtGsm.value = "";
    
    txtFirstnameChild.value = "";
    txtLastnameChild.value = "";
    txtLeeftijdChild.value = "";
    txtBeschrijvingChild.value = "";
    
    txtQr_code.value = "";

    txtEmail.value = "";
    txtPassword.value = "";
})
.catch(function(error) {
    console.error("Error bij user gegevens weg te schrijven naar database: ", error);
});
  
  addQRcodeToDatabase(QR_code_input,userIdEmail);
}

function addQRcodeToDatabase(meegekregenQRcode,userId){
  console.log(meegekregenQRcode);
  db.collection("QR-codes").doc(meegekregenQRcode).set({
    qrcode: meegekregenQRcode,
    ouders_id: userId
  })
}


/* CREATE USER ACCOUNT - EMAIL AND PASSWORD --------------------------------------------------------------------------------------------------*/
function createUserAccount(){
  console.log("Create useraccount");
  const email = txtEmail.value;
  const password = txtPassword.value;
  const auth = firebase.auth()
  
  //Sign up account
  const promise = auth.createUserWithEmailAndPassword(email,password);
  
  //Geeft code mee van degene die inlogt op admin, en niet die van het account dat wordt aangemaakt
  
 
}

firebase.auth().onAuthStateChanged(firebaseUser => {
  if(firebaseUser){
    firebaseUserId = firebaseUser.uid;
    console.log("firebaseUserId: " + firebaseUserId);
    //btnLogout.classList.remove('hide');
    addDataUserToDatabase(firebaseUser.uid);
  }else{
    //btnLogout.classList.add('hide');
  }
});

//btnLogout.addEventListener('click',e =>{
//  firebase.auth().signOut();
//  window.location.href = "index.html";
//});