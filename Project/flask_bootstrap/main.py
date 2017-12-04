from flask import Flask, render_template, flash
from flask_wtf import Form 
from wtforms import StringField, PasswordField
from wtforms.validators import InputRequired, Email, Length, AnyOf
from flask_bootstrap import Bootstrap
import pyodbc



app = Flask(__name__)
Bootstrap(app)
app.config['SECRET_KEY'] = 'DontTellAnyone'

#Login object used to create form.
class LoginForm(Form):
	email = StringField('Email', validators=[InputRequired(), Email(message='Not a valid email')])
	username = StringField('Username', validators=[InputRequired(), Length(min=5, max=20)])
	password = PasswordField('Password', validators=[InputRequired(), Length(min=8, max=20)])


#Connecting to the database.
conn = pyodbc.connect(r'DSN=gameDB;UID=user;PWD=password')
cursor = conn.cursor()

#This is to check the database conntains the
#or the password already.
#If it contains either, do not allow the user
#to add that to the database.
def isValid(cursor, form):
	#get the count of same usernames in database.
	command1 = "select count(username) from _user where username = '" + form.username.data + "';"
	cursor.execute(command1)
	count_of_username = cursor.fetchall()
	#get the count of same emails in the database.
	command2 = "select count(email) from _user where email = '" + form.email.data + "';"
	cursor.execute(command2)
	count_of_email = cursor.fetchall()
	return not (str(count_of_email) == "[(1, )]" and str(count_of_username) == "[(1, )]")


#This is a test to make sure that the user information
#is valid to enter it into the database.
def insertIntoTable(cursor, form):
	#insert data into the _user table
	insert_command = "INSERT INTO _user (email, username, password) VALUES ('" + form.email.data + "', '" + form.username.data + "', '" + form.password.data + "');"
	cursor.execute(insert_command)
	cursor.commit()


@app.route('/', methods=['GET', 'POST'])
def index():
	form = LoginForm()
	if form.validate_on_submit() and isValid(cursor, form):
		insertIntoTable(cursor, form)
		return 'Form Successfully Submitted!'
	return render_template('index.html', form=form)

if __name__ == '__main__':
	app.run(debug=True)