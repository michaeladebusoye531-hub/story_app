from flask import Flask, render_template, request, redirect, url_for
import sqlite3

app = Flask(__name__)

def get_db_connection():
    connection = sqlite3.connect("storyspace.db")
    connection.row_factory = sqlite3.Row
    connection.execute("PRAGMA foreign_keys = ON")
    return connection


@app.route("/")
def homepage():
    return render_template("index.html")


@app.route("/publish", methods=["POST"])
def publish_story():

    title = request.form["title"]
    category = request.form["category"]
    description = request.form["description"]
    content = request.form["content"]

    connection = get_db_connection()

    # Temporary guest writer until registration is added
    connection.execute("""
        INSERT OR IGNORE INTO users (username, email, password)
        VALUES (?, ?, ?)
    """, ("Guest Writer", "guest@storyspace.local", "temporary"))

    user = connection.execute(
        "SELECT user_id FROM users WHERE email = ?",
        ("guest@storyspace.local",)
    ).fetchone()

    connection.execute("""
        INSERT INTO stories
        (user_id, title, category, description, content)
        VALUES (?, ?, ?, ?, ?)
    """, (user["user_id"], title, category, description, content))

    connection.commit()
    connection.close()

    return redirect(url_for("homepage"))


if __name__ == "__main__":
    app.run(debug=True)