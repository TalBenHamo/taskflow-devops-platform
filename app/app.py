from flask import Flask, render_template

app = Flask(__name__)

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
        tasks=TASKS,
    )

@app.route("/health")
def health():
    return {"status": "healthy"}, 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
