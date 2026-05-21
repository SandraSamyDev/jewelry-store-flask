from flask import Flask
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired, Length , InputRequired

class LoginForm(FlaskForm):
    username=StringField(
        "username",
          validators=[InputRequired()])
    
    password=PasswordField("" \
    "password", 
    validators=[InputRequired()])

    submit=SubmitField("Login")
