import os
from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv("DATABASE_URL")
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)

class Task(db.Model):
    __tablename__ = "tasks"

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    status = db.Column(db.String(50), nullable=False, default="Open")
    assignee = db.Column(db.String(100), nullable=False)

    def __repr__(self):
        return f"<Task {self.name}>"


PROJECT_NAME = "TaskFlow DevOps Platform"
TEAM_MEMBER = "Tal Ben Hamo"

TASKS = [
    {
        "name": "Design TaskFlow application",
        "status": "In Progress",
        "assignee": "Tal Ben Hamo",
    },
    {
        "name": "Containerize the application",
        "status": "Open",
        "assignee": "Tal Ben Hamo",
    },
    {
        "name": "Build CI/CD pipeline",
        "status": "Open",
        "assignee": "Tal Ben Hamo",
    },
]


@app.route("/")
def index():
    return render_template(
        "index.html",
        project_name=PROJECT_NAME,
        team_member=TEAM_MEMBER,
	tasks=Task.query.all(),
    )


@app.route("/health")
def health():
    return {"status": "healthy"}, 200


if __name__ == "__main__":
    # יצירת הטבלאות בבסיס הנתונים במידה והן לא קיימות
    with app.app_context():
        db.create_all()

app.run(host="0.0.0.0", port=5000, debug=False)
