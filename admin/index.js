
const txtEmail = document.getElementById("email");
const txtWachtwoord = document.getElementById("wachtwoord");



function loginToAdminpaneel(){
  //console.log("Login to adminpaneel");
  
  const ingevoerd_email = txtEmail.value;
  const ingevoerd_wachtwoord = txtWachtwoord.value;
  
  console.log(ingevoerd_email , ingevoerd_wachtwoord);
  
  db.collection("Admins").get().then((querySnapshot) => {
    querySnapshot.forEach((doc) => {
        //console.log(`${doc.id} =>`, doc.data());
        const admins = doc.data();
        const admins_emails = doc.data().email;
        //console.log("Email: " + admins_emails);
        //console.log(doc.data().email);
//        if (ingevoerd_email == doc.data().email && ingevoerd_wachtwoord == doc.data().wachtwoord) {
//          console.log("Email en wachtwoord kloppen, log user in");
//          window.location.href = "add_users.html";
//        }else{
//          console.log("Gegevens zijn niet correct!"); 
//          txtEmail.classList.remove('veld');
//          txtEmail.classList.add('fout');
//          
//          txtWachtwoord.classList.remove('veld');
//          txtWachtwoord.classList.add('fout');
//          
//        }
      if (ingevoerd_email == doc.data().email && ingevoerd_wachtwoord == doc.data().wachtwoord) {
          console.log("Email en wachtwoord kloppen, log user in");
          window.location.href = "add_users.html";
        }else{
          if(ingevoerd_email != doc.data().email){
            console.log("Gegeven email zijn niet correct!"); 
            txtEmail.classList.remove('veld');
            txtEmail.classList.add('fout');
          }
          if(ingevoerd_wachtwoord != doc.data().wachtwoord){
            console.log("Gegeven wachtwoord zijn niet correct!"); 
            txtWachtwoord.classList.remove('veld');
            txtWachtwoord.classList.add('fout');
          }
          if(ingevoerd_email == doc.data().email){
            console.log("Gegeven email zijn niet correct!"); 
            txtEmail.classList.remove('fout');
            txtEmail.classList.add('veld');
          }
          if(ingevoerd_wachtwoord == doc.data().wachtwoord){
            console.log("Gegeven wachtwoord zijn niet correct!"); 
            txtWachtwoord.classList.remove('fout');
            txtWachtwoord.classList.add('veld');
          }
        }
      
      
    });
});
  
  //Check in database of email en wachtwoord klopt bij een admin
  //Als correct => redirect naar adminpaneel
  
}

//fout

//.classList.add('hide');