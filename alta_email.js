var system = require('system');

var page = require('webpage').create();
/*page.onConsoleMessage = function(msg) {
    system.stderr.writeLine('console: ' + msg);
};*/
username = system.args[1]
password = system.args[2]

page.open('https://webmail.apicv.net/admin/ui/login', function() {
  page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js", function() {
	  page.evaluate(function(admin_email, admin_passwd) {
		  $('input[name="email"]').val(admin_email);
		  $('input[name="pw"]').val(admin_passwd);
		  $('input#submit.btn.btn-default').click();
	  }, system.env['ADMIN_EMAIL'], system.env['ADMIN_PASSWD']);
	  //page.render("alta_email1.png");
	  setTimeout(function(){
	  //page.render("alta_email2.png");
	    page.open('https://webmail.apicv.net/admin/ui/user/create/docent.apicv.net', function () {
	        setTimeout(function(){
	            page.evaluate(function(inner_username, inner_password) {
	                $('input#localpart').val(inner_username);
	                $('input#pw').val(inner_password);
	                $('input#pw2').val(inner_password);
	                $('input#submit').click();
	            }, username, password);
	            //page.render("alta_email3.png");
	            setTimeout(function(){
	                //page.render("alta_email.png");
                    phantom.exit();
                }, 1000);
	        }, 1000);
	    });
    }, 1000);
  });
});
