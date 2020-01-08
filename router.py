from models import *
import json
import os.path
import re



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

def delete_comment(query):
    delete_status = delete_by_id(query['id'])
    return json.dumps(delete_status)

    
def test():
    response = get_all_comments()
    print(response)
    return json.dumps(response)

def regions():
    response = get_regions()
    return json.dumps(response)

def cities(query):
    response = get_cities_by_id(query['id'])
    return json.dumps(response)

def addcomment(data):
    add_status = add_comment(data)
    return json.dumps(add_status)

def stat():
    return render('stat.html')

def getstat():
    statistics = get_statistics()
    return json.dumps(statistics)

URLS = {
    '/':[index,'GET'],
    '':[index,'GET'],
    '/index':[index,'GET'],
    '/comment':[comment,'GET'],
    '/view':[view,'GET'],
    '/static':[static, 'GET'],
    '/test':[test,'GET'],
    '/delete':[delete_comment,'DELETE'],
    '/regions':[regions,'GET'],
    '/cities':[cities, 'POST'],
    '/addcomment':[addcomment, 'POST'],
    '/stat':[stat, 'GET'],
    '/getstat':[getstat, 'GET'],
}

def parse_request(request):
    splited_request = request.split(' ')
    method = splited_request[0]
    url = splited_request[1]
    json_query= ''
    regex = re.compile('json_request ({.+})')
    match = regex.search(request)
    if match:
        json_query = match.group(1)
    return (method, url, json_query)

def generate_headers(method, url):
    if '/static/' in url and os.path.isfile(url[1:]):
        return ('HTTP/1.1 200 OK \n\n', 200)
    if not url in URLS:
        return ('HTTP/1.1 404 Not Found\n\n', 404)
    if not method in URLS[url]:
        return ('HTTP/1.1 405 Method not allowed\n\n', 405)
    return ('HTTP/1.1 200 OK \n\n', 200)

def generate_content(code, url, json_query):
    if code == 404:
        return '<h1>404</h1><p>Not found</p>'
    if code == 405:
        return '<h1>405</h1><p>Method not allowed</p>'
    if '/static/' in url:
        return URLS['/static'][0](url)
    if json_query:
        query = json.loads(json_query)
        return URLS[url][0](query)
    
    return URLS[url][0]()

def generate_response(request):
    method, url, json_query = parse_request(request)
    headers, code = generate_headers(method, url)
    body = generate_content(code, url, json_query)

    print(f'<===Response with code: {code}')
    print()
    print('*'*25)
    return (headers + body).encode()
    