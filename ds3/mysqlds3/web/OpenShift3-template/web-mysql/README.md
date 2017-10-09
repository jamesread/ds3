OpenShift 3 template for DS3 web container (php5, centos7) and MySQL container
===

# Running the template

To deploy, simply login to OpenShift and select a project to deploy into;

	oc login...
	oc project ds3-from-template

Then use the Makefile

	make install
	make create

To clean up and start again (keeping config maps & persitent volumes - mysql)

	make delete

# Post-deploy

In OpenShift, go to the MySQL container, and launch a terminal.

Download and run the database setup SQL files (note that root has an empty password);

	curl -O https://raw.githubusercontent.com/dvdstore/ds3/master/ds3/mysqlds3/build/mysqlds3_create_db.sql
	mysql -u root -p < mysqlds3_create_db.sql

	curl -O https://raw.githubusercontent.com/dvdstore/ds3/master/ds3/mysqlds3/build/mysqlds3_create_ind.sql
	mysql -u root -p < mysqlds3_create_ind.sql

	curl -O https://raw.githubusercontent.com/dvdstore/ds3/master/ds3/mysqlds3/build/mysqlds3_create_sp.sql
	mysql -u root -p < mysqlds3_create_sp.sql

You should also turn off all sensible modern MySQL validation, because the web app does not "support" it... 

	mysql -u root -p -e 'SET GLOBAL sql_mode = "NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" '

Recommend to leave the MySQL terminal open, as it's useful for debugging the web app.

# Open the Web App

In OpenShift, a route should have been created for you for the web app. If you open the route in a new tab, you should
see the default RHEL Apache homepage.

The DS3 Web application is at; http://<yourroute>/ds3/mysqlds3/web/php5/
