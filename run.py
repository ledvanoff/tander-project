import socket
from router import *
from models import *

#Функция запуска сервер-соккета
def run(ip='localhost', port=5000):
    create_db()
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM) #IPv4, TCP
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1) #переиспользовать предыдущий адрес без таймаута
    server_socket.bind((ip,port))
    server_socket.listen()
    while True:
        client_socket, client_addr = server_socket.accept()
        request = client_socket.recv(2048)
        if not request:
            print('WARN!Empty request detected')
            continue
        print(f'===>Request from {client_addr} :')
        print(request.decode('utf-8'))
        response = generate_response(request.decode('utf-8'))
        client_socket.sendall(response)
        client_socket.close()

if __name__ == "__main__":
    run()