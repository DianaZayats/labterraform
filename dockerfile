
FROM python:3.10


WORKDIR /app


COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt


COPY . .

RUN python -m unittest discover -s . -p "test_*.py"

EXPOSE 80

CMD ["python", "app.py"]
#test