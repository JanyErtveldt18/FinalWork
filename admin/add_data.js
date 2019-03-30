//Initialiseren firestore door firebase
//var db = firebase.Firestore();

const txtFirstname = document.getElementById("firstname");
const txtLastname = document.getElementById("lastname");
const txtEmail = document.getElementById("email");
const txtPassword = document.getElementById("password");


function addDataUserToDatabase(userIdEmail){
  console.log("Voeg gegevens user toe aan account");
  var firstname_input = txtFirstname.value;
  var lastname_input = txtLastname.value;
  
  db.collection("Users").doc(userIdEmail).set({
    name: firstname_input,
    lastname: lastname_input
})
.then(function() {
    console.log("User gegevens met succes naar database geschreven!");
    firebase.auth().signOut();
    txtFirstname.value = "";
    txtLastname.value = "";
    txtEmail.value = "";
    txtPassword.value = "";
})
.catch(function(error) {
    console.error("Error bij user gegevens weg te schrijven naar database: ", error);
});
  
  
}


/* CREATE USER ACCOUNT - EMAIL AND PASSWORD --------------------------------------------------------------------------------------------------*/
function createUserAccount(){
  console.log("Create useraccount");
  const email = txtEmail.value;
  const password = txtPassword.value;
  const auth = firebase.auth()
  
  //Sign up account
  const promise = auth.createUserWithEmailAndPassword(email,password);  
  
 
}

firebase.auth().onAuthStateChanged(firebaseUser => {
  if(firebaseUser){
    console.log(firebaseUser.uid);
  }else{
    console.log("Nobody logged in");
  }
  
   addDataUserToDatabase(firebaseUser.uid);
});