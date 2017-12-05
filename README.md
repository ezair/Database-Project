# Database-Project
Database project. Contains a website that links to a local server. A game made in UE4 also connects to database.


#REQUIREMENTS TO RUN PROGRAM
  #The following python libraries are required to run the main.py script.
    1) pip & python-setuptools
    2  bootstrap
    3) flask
    4) wtforms
    5) flask_bootstrap
    6) pyodbc
    7) flask_wtf
    

    If you have any trouble with this just remember that you need to make the following dependencies exist:
        from flask import Flask, render_template, flash
        from flask_wtf import Form 
        from wtforms import StringField, PasswordField
        from wtforms.validators import InputRequired, Email, Length, AnyOf
        from flask_bootstrap import Bootstrap
        import pyodbc  


#Make sure to change the connection to the database (located in the main.py file) to your Dns servername.



#Make sure to change all of the cursor.pyodbc commands to work with your database table names. They will have to be changed in the main.py script to flow with your database and your tables.



#The main.py script must be created in order for your login page to be displayed.
