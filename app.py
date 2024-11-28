from flask import Flask
from order_stack import OrderStack  # Імпорт вашого класу OrderStack

app = Flask(__name__)
orders = OrderStack()

@app.route('/')
def index():
    return "Flask app with OrderStack"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
