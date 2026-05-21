from flask import Flask, render_template, redirect, request, url_for
from dotenv import load_dotenv
import os
from flask import session
from flask_sqlalchemy import SQLAlchemy
from forms.login import LoginForm
from forms.register import RegisterForm
from werkzeug.security import generate_password_hash, check_password_hash
from models.User import User
from extentions import db


load_dotenv("secret.env")

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv("SQLALCHEMY_DATABASE_URI")
app.config["SECRET_KEY"] = os.getenv("SECRET_KEY")

db.init_app(app)


@app.route("/")
def home():
    return render_template("home.html")


@app.route("/login", methods=["GET", "POST"])
def login():
    form = LoginForm()
    msg = request.args.get("msg")

    if request.method == "POST" and form.validate_on_submit():

        user = User.query.filter_by(username=form.username.data).first()

        # check user exists
        if not user:
            return redirect(url_for("login", msg="User not found"))

        # check password
        if check_password_hash(user.password_hash, form.password.data):

            # store login session
            session["user_id"] = user.id
            session["username"] = user.username

            return redirect(url_for("home"))

        else:
            return redirect(url_for("login", msg="Incorrect password"))

    return render_template("login.html", form=form, msg=msg)


@app.route("/register", methods=["GET", "POST"])
def register():
    form = RegisterForm()

    if request.method == "POST" and form.validate_on_submit():

        # check if email already exists
        user_exists = User.query.filter_by(email=form.email.data).first()

        if user_exists:
            return render_template(
                "register.html",
                form=form,
                error="Email already exists"
            )

        # create new user
        new_user = User(
            username=form.username.data,
            email=form.email.data,
            password_hash=generate_password_hash(form.password.data),
            is_admin=False
        )

        db.session.add(new_user)
        db.session.commit()

        return redirect(url_for("login", msg="Account created successfully"))

    return render_template("register.html", form=form)


@app.route("/products")
def products():
    return render_template("products.html")


@app.route("/product/<int:id>")
def product_details(id):
    return render_template("product_details.html", product_id=id)


@app.route("/cart")
def cart():
    return render_template("cart.html")



@app.route("/checkout")
def checkout():
    return "Checkout Page"



@app.route("/admin")
def admin():
    return render_template("admin_page.html")



@app.route("/update")
def update():
    return render_template("update_page.html")



@app.route("/delete/<int:id>")
def delete(id):
    return redirect(url_for("home"))


if __name__ == "__main__":
    app.run(debug=True)