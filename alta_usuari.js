var system = require('system');

var page = require('webpage').create();
/*page.onConsoleMessage = function(msg) {
    system.stderr.writeLine('console: ' + msg);
};*/

generatedPassword = 'empty';
firstname = system.args[1];
lastname = system.args[2];
username = system.args[3];
email = system.args[4]

page.open('https://usuaris.apicv.net/log_in', function() {
  page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js", function() {
	  page.evaluate(function(admin_user, admin_passwd) {
		  $('input[name="user_id"]').val(admin_user);
		  $('input[name="password"]').val(admin_passwd);
		  $('button.btn').click();
	  }, system.env['ADMIN_USER'], system.env['ADMIN_PASSWD']);

	  setTimeout(function(){
	    page.open('https://usuaris.apicv.net/account_manager/new_user.php', function () {
	        setTimeout(function(){
	            generatedPassword = page.evaluate(function(inner_firstname, inner_lastname, inner_username, inner_email) {
	                $('input#password_generator').click();
	                $('input[name="givenname"]').val(inner_firstname);
	                $('input[name="sn"]').val(inner_lastname);
	                $('input[name="uid"]').val(inner_username);
	                $('input[name="mail"]').val(inner_email);
	                generatedPassword = $('input[name="password"]').val()
	                $('input[name="confirm"]').val($('input[name="password"]').val())
	                $('button.btn-warning').click();
	                return generatedPassword;
	            }, firstname, lastname, username, email);
	            setTimeout(function(){
	                //page.render("out/"+generatedPassword+"alta_usuari.png");
                    console.log(generatedPassword);
					page.close();
                    phantom.exit(0);
                }, 1000);
	        }, 1000);
	    });
      }, 1000);
  });
});


