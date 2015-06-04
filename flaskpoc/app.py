from flask.ext.script import Manager
from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello World!'

manager = Manager(app)


def main():
    manager.run()

if __name__ == '__main__':
    main()
