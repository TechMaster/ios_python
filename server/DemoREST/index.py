from sanic import Sanic
from sanic.response import json

app = Sanic()


@app.route("/")
async def test(request):
    return json([
        {
            "id": 1,
            "title": "Post 1"
        },
        {
            "id": 2,
            "title": "Post 2"
        },
        {
            "id": 3,
            "title": "Post 3"
        }
    ])


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
