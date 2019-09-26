from sanic import Sanic
from sanic import response

app = Sanic()


# users = []  # Bước 0: Khởi tạo một danh sách user rỗng
# Bước 4: vào Mockaroo để sinh dữ liệu JSON đểu chạy tạm cái đã
# Bước 6: đóng gói các phương thức tác động lên danh sách user vào một class. Cách này là thủ thuật lập trình hướng đối tượng
# kinh phết đấy!
class Users:
    def __init__(self):
        self.users = [{
            "id": 1,
            "name": "Mable Leander",
            "email": "mleander0@squidoo.com",
            "password": "YtsCnp8IpCL",
            "photo": "01.jpg"
        }, {
            "id": 2,
            "name": "Maegan Gaiger",
            "email": "mgaiger1@mysql.com",
            "password": "VhqSaDfK",
            "photo": "02.jpg"
        }, {
            "id": 3,
            "name": "Jon Duke",
            "email": "jduke2@woothemes.com",
            "password": "LQtlJTI962",
            "photo": "03.jpg"
        }, {
            "id": 4,
            "name": "Magdalene Purcell",
            "email": "mpurcell3@taobao.com",
            "password": "Q4fK89VdR8r",
            "photo": "04.jpg"
        }, {
            "id": 5,
            "name": "Arleyne Caveney",
            "email": "acaveney4@elpais.com",
            "password": "3dZ5DuSRck",
            "photo": "05.jpg"
        }]

    def get_all_users(self):
        return self.users

    def get_an_user(self, id):
        for user in self.users:
            if user['id'] == int(id):
                return user

        return None

    # Bước 7B
    def create_a_new_user(self, user):
        user['id'] = self.get_next_id()
        self.users.append(user)
        return user['id']

    # Bước 7C
    def get_next_id(self):
        return self.users[-1]['id'] + 1

    # Bước 8A
    def delete_an_user(self, id):
        index = int(id)
        delete_success = False
        for user in self.users:
            if user['id'] == index:
                self.users.remove(user)
                delete_success = True
                break

        return delete_success

    # Bước 9A
    def update_an_user(self, update_form):
        index = int(update_form.get("id"))
        update_success = False
        for user in self.users:
            if user['id'] == index:
                for key in update_form.keys():
                    if key != "id" and (key in user.keys()):
                        user[key] = update_form.get(key)
                        update_success = True
        return update_success


# --------------
users = Users()


# Bước 1: tạo cái homepage cho vui
@app.route("/")
async def homepage(request):
    return response.html("<htm>"
                         "<head><title>Hello</title></head>"
                         "<body><h1>Chương trình quản lý nhân sự</h1>"
                         "</body>"
                         "</html>")


# Bước 2: bổ xung GET /users trả về danh sách tất cả users
@app.route("/users")
async def get_all_users(request):
    return response.json(users.get_all_users())


# Bước 5: bổ xung GET /user trả về user cụ thể ứng với id người dùng truyền lên
@app.route("/user")
async def get_an_user_by_id(request):
    index = request.form.get("id")
    return response.json(users.get_an_user(index))


# Bước 7A
@app.route("/user", methods=['POST'])
async def add_a_new_user(request):
    new_user = {
        "name": request.form.get("name"),
        "email": request.form.get("email"),
        "password": request.form.get("password"),
    }
    new_id = users.create_a_new_user(new_user)

    return response.json(new_id)


# Bước 8: Xóa
@app.route("/user", methods=['DELETE'])
async def delete_an_user(request):
    index = request.form.get("id")
    return response.json(users.delete_an_user(index))


# Bước 9: Cập nhật
@app.route("/user", methods=["PUT"])
async def update_an_user(request):
    return response.json(users.update_an_user(request.form))


'''
Client có thể gửi request lên dưới mấy dạng:
- form-data: phía server sẽ dùng request.form để lấy dữ liệu
- x-www-url-encode: phía server có thể dùng request.form hoặc request.body
- raw + json: phía server phải dùng request.body
https://stackoverflow.com/questions/26723467/what-is-the-difference-between-form-data-x-www-form-urlencoded-and-raw-in-the-p
'''

if __name__ == "__main__":
    app.static('/photo', './uploads')
    app.run(host="0.0.0.0", port=8000)
