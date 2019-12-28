from models import *
import json
from urllib import parse
import os.path



def render(template_name):
    with open('templates/{}'.format(template_name),'r',encoding='utf8') as template:
        return template.read()

def static(url):
    with open(url[1:],'r',encoding='utf8') as static:
        return static.read()

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


URLS = {
    '/':[index,'GET'],
    '':[index,'GET'],
    '/comment':[comment,'GET'],
    '/view':[view,'GET'],
    '/static':[static, 'GET'],
    '/test':[test,'GET']
}


def parse_request(request):
    splited_request = request.split(' ')
    method = splited_request[0]
    url = splited_request[1]
    query_params = parse.urlsplit(url).query#парсим запросы из урла
    queries_dict = parse.parse_qs(query_params)
    return (method, url)

def generate_headers(method, url):
    if '/static/' in url and os.path.isfile(url[1:]):
        return ('HTTP/1.1 200 OK \n\n', 200)
    if not url in URLS:
        return ('HTTP/1.1 404 Not Found\n\n', 404)
    if not method in URLS[url]:
        return ('HTTP/1.1 405 Method not allowed\n\n', 405)
    return ('HTTP/1.1 200 OK \n\n', 200)

def generate_content(code, url):
    if code == 404:
        return '<h1>404</h1><p>Not found</p>'
    if code == 405:
        return '<h1>405</h1><p>Method not allowed</p>'
    if '/static/' in url:
        return URLS['/static'][0](url)
    
    return URLS[url][0]()

def generate_response(request):
    method, url = parse_request(request)
    headers, code = generate_headers(method, url)
    body = generate_content(code, url)

    print('<===Response with code: {}'.format(code))
    print()
    print('*'*25)
    return (headers + body).encode()
    