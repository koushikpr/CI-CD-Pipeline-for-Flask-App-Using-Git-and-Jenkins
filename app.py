from flask import Flask, render_template, request, url_for, redirect
from flask_pymongo import PyMongo
from bson.objectid import ObjectId
from pymongo import MongoClient
import sys
app = Flask(__name__)

host = sys.argv[1]


#Provide your MongoDB Container name here instead of flaskapp-db-1
client = MongoClient(host,27017)

todos = client.db.todos



#CREATE
@app.route('/add', methods=['POST'])
def add_todo():
    new_todo = request.form.get('new-todo')
    todos.insert_one({'text' : new_todo, 'complete' : False})
    return redirect(url_for('index'))


#READ
@app.route('/')
def index():
    saved_todos = todos.find()
    return render_template('index.html', todos=saved_todos)


#UPDATE
@app.route('/complete/<oid>')
def complete(oid):
    todo_item = todos.find_one({'_id': ObjectId(oid)})
    todo_item['complete'] = True
    todos.save(todo_item)
    return redirect(url_for('index'))


#DELETE
@app.route('/delete_completed')
def delete_completed():
    todos.delete_many({'complete' : True})
    return redirect(url_for('index'))

#DELETE ALL
@app.route('/delete_all')
def delete_all():
    todos.delete_many({})
    return redirect(url_for('index'))


#INITIALIZATION
if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)