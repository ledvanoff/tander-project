from models import *
import json

def render(template_name):
    with open('templates/{}'.format(template_name),'r',encoding='utf8') as template:
        return template.read()

def index():
    return render('index.html')

def comment():
    return render('comment.html')

def view():
    return render('view.html')
    
def test():
    response = get_all_comments()
    response_to_json = json.dumps(response)
    return response_to_json



    