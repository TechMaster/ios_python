import os

from sanic import Sanic
from sanic import response

app = Sanic()
dir_path = os.path.dirname(os.path.realpath(__file__))
app.config.filefolder = dir_path + "/uploads"

app.static('/uploads', './uploads')
@app.route("/")
async def homepage(request):
    return response.html("<htm>"
                         "<head><title>Hello</title></head>"
                         "<body><h1>Chào anh Đạt</h1>"
                         "<img src='/uploads/cat.jpg'>"
                         "</body>"
                         "</html>")


@app.route("/upload", methods=['POST'])
async def on_file_upload(request):
    if not os.path.exists(app.config.filefolder):
        os.makedirs(app.config.filefolder)
    for file_upload in request.files["file"]:
        print(app.config.filefolder + "/" + file_upload.name)
        f = open(app.config.filefolder + "/" + file_upload.name, "wb")
        f.write(file_upload.body)
        f.close()

    return response.json(True)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
